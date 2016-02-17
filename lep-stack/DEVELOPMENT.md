# Development

## Containers
- [mysql](https://www.mysql.com/)
- [redis](http://redis.io/)
- [kibana](https://www.elastic.co/products/kibana): UI to access all logs coming from the `app` container
- [elasticsearch](https://www.elastic.co/products/elasticsearch): stores logs from the `app` container and is used by the `kibana` container to access logs
- [app](http://releases.ubuntu.com/14.04/): Ubuntu 14.04 custom LEP (Linux NGINX PHP) stack
    + PHP Modules
        * php5-gd
        * php5-imagick
        * php5-memcached
        * php5-mysql
        * php5-pgsql
        * php5-redis
        * php5-xdebug
    + Tools
        * [Composer](https://getcomposer.org/)
        * [NodeJS](https://nodejs.org/)
        * [NPM](https://www.npmjs.com/)
            - grunt-cli
        * [Ruby](https://www.ruby-lang.org/en/)
        * [MySQL Client](http://dev.mysql.com/doc/refman/5.7/en/mysql.html)
        * [Blackfire](https://blackfire.io/) Probe
    + Libraries
        * [ImageMagick](http://www.imagemagick.org/)
        * [GraphicsMagick](http://www.graphicsmagick.org/)

## Running dev environment

### Step 1
Install [Docker Toolbox](https://www.docker.com/products/docker-toolbox)

### Step 2
If you're on OSX or Windows you will need to use **docker-machine** to run docker.  
First you need to create a default machine:
```sh
docker-machine create --driver virtualbox default
```

Then you need to start it:
```sh
docker-machine start default
```

And after that you need to know what is the IP of the `docker-machine` so that you can access containers running within it. Check `DOCKER_HOST` on the output of the following command:
```sh
docker-machine env default
```

### Step 3: Set environment variables
Add any needed environment variables to `app/.env`

### Step 4: Launch containers
To launch the development environment you just need to run:

```sh
docker-compose up -d
```

You can check the status of the containers by running:
```sh
docker-compose logs
```

These containers/services should now be acessible to you from you local system:
- **app:** `$DOCKER_HOST`:8888
- **mysql:** `$DOCKER_HOST`:8306
- **redis:** `$DOCKER_HOST`:6379
- **kibana:** `$DOCKER_HOST`:5601
- **elasticsearch:** `$DOCKER_HOST`:9200

If you need to connect to a container/service from within another container (e.g. setting `.env` variables for the `app` container) you need to use the following URLs:

- **app:** app:8888
- **mysql:** mysql:8306
- **redis:** redis:6379
- **kibana:** kibana:5601
- **elasticsearch:** elasticsearch:9200

### Step 5: Import database
One of the containers started via `docker-compose` is a mysql container, so we added a tool to easily import staging or production databases into the development environment.

You can simply pass a database URL like this:
```sh
docker-compose run app mysql-import -r mysql://user:pass@host/database_name
```

Or you can pass an environment name that will try to fetch the database url from the `.env` file for that specific environment (.e.g .env-staging; .env-production)
```sh
docker-compose run app mysql-import -e staging
```

### Step 6: Setting up Kibana
**tbd**

## Tools
**tbd**

## Troubleshooting
**tbd**