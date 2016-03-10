#!/usr/bin/env bash

# fail fast
set -e

# Usage information
show_help() {
cat << EOF
Usage: ${0##*/} [-hl] [-e ENVIRONMENT] [-f DB_URL]...

Set either environment alias or remote db url, not both.
	
	-a APP_ROOT    application root (default: /app/)
	-e ENVIRONMENT environment alias
	-r DB_URL      remote database url
    -h             display this help and exit
EOF
}

# Parse database url
parse_db_url() {

	# Remove mysql:// from database url
	DB_URL=${1//mysql:\/\//}

	# Split credentials and connection
	DB_URL_DATA=(${DB_URL//\@/ })
	DB_CREDENTIALS=${DB_URL_DATA[0]}
	DB_CONNECTION=${DB_URL_DATA[1]}

	# Get username and password
	DB_CREDENTIALS_DATA=(${DB_CREDENTIALS//\:/ })
	DB_USER=${DB_CREDENTIALS_DATA[0]}
	DB_PASS=${DB_CREDENTIALS_DATA[1]}

	# Get host and database name
	DB_CONNECTION_DATA=(${DB_CONNECTION//\// })
	DB_HOST=${DB_CONNECTION_DATA[0]}
	DB_NAME=${DB_CONNECTION_DATA[1]}
}

# Initialize our own variables:
APP_ROOT=/app/
ENVIRONMENT=""
DB_URL=""
VERBOSE="false"

while getopts "va:e:r:h" opt; do
    case "$opt" in
    	v)
			VERBOSE="true"
			;;
    	a) 
			APP_ROOT=$OPTARG
			;;
    	e) 
			ENVIRONMENT=$OPTARG
			;;
        r)  DB_URL=$OPTARG
            ;;
        h)
            show_help
            exit 0
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done

if [[ -n $ENVIRONMENT && -n $DB_URL ]]; then
	show_help
	exit 1
fi

echo ''
echo '----> DB Import'

# Get database url from environment variables file
if [[ -n $ENVIRONMENT ]]; then
	
	ENV_FILE=$APP_ROOT'.env-'$ENVIRONMENT

	# Check if environment file exists
	if [ ! -f $ENV_FILE ]; then
		echo "\"$ENV_FILE\" does not exist, so we cannot extract a database URL"
		echo ""
		exit 1
	fi

	# Read environment file
	while read var; do

		# Intercept DB_URL
		if [[ "$var" = "DB_URL"* ]]; then
			
			varData=(${var//=/ })
			DB_URL=${varData[1]}
			break
		fi  

	done < "$ENV_FILE"

	# Check if we have a DB_URL
	if [[ -z "$DB_URL" ]]; then
		echo "\"$ENV_FILE\" does not have a \"DB_URL\" variable, so we cannot extract a database URL"
		echo ""
		exit 1
	fi
fi

# Parse DB_URL
parse_db_url $DB_URL

if [[ "$VERBOSE" = "true" ]]; then

	echo "    > USER: "$DB_USER
	echo "    > PASS: "$DB_PASS
	echo "    > HOST: "$DB_HOST
	echo "    > NAME: "$DB_NAME
fi

if [[ -n $DB_USER && -n $DB_PASS && -n $DB_HOST && -n $DB_NAME ]]; then

	echo '    > Clearing local database'
	mysql -h mysql -u root -e "DROP DATABASE dev; CREATE DATABASE dev;"
	
	echo '    > Extracting target remote database and importing to local one'
	mysqldump -v -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS"  "$DB_NAME" | mysql -h mysql -u root dev
	
	echo "    > Done!!!"
	echo ""
	exit 0
else 

	echo '    > DB_URL should be a valid URL (e.g. mysql://user:pass@host/database_name)'
	echo ""
	exit 1
fi