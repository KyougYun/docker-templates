LEP Stack
---

## Stack
- [Ubuntu Trusty 14.04](http://releases.ubuntu.com/14.04/)
- [Nginx](http://nginx.org/)
- [PHP5](http://www.php.net/)
- [Supervisor](http://supervisord.org/)

### PHP Modules
- mysql
- pgsql
- xdebug 
- memcached
- redis
- gd
- imagick 

## Dev tools
- [Composer](https://getcomposer.org/)
- [NodeJS](https://nodejs.org/)
- [NPM](https://www.npmjs.com/)
- [Grunt CLI](http://gruntjs.com/)
- [Blackfire](https://blackfire.io/)

## Logging Tools
- [Elastic Filebeat](https://www.elastic.co/products/beats/filebeat): Shipper for Log Data
- [Elastic Topbeat](https://www.elastic.co/products/beats/topbeat): Shipper for Resource Usage Metrics
- [Elastic Packetbeat](https://www.elastic.co/products/beats/packetbeat): Real-Time Network Packet Analytics

## Custom Tools
### MySQL Import
One of the development containers started via `docker-compose` is a mysql container, so we added a tool to easily import staging or production databases into the development environment.

You can simply pass a database URL like this:
```sh
docker-compose run app mysql-import -r mysql://user:pass@host/database_name
```

Or you can pass an environment name that will try to fetch the database url from the `.env` file for that specific environment (.e.g .env-staging; .env-production)
```sh
docker-compose run app mysql-import -e staging
```