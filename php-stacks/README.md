LEP Stack
---

## Stack
- [Ubuntu 16.04 LTS (Xenial Xerus)](http://releases.ubuntu.com/16.04/)
- [Nginx (Extras)](http://packages.ubuntu.com/xenial/nginx-extras)
- [PHP7](http://www.php.net/)
- [Supervisor](http://supervisord.org/)

### PHP7 Modules
- curl
- gd
- imagick
- mbstring
- mysql
- pgsql
- memcached
- redis
- soap

## System Tools
- [zsh](http://www.zsh.org/)
- [htop](https://hisham.hm/htop/)

## Dev tools
- [Vim](http://www.vim.org/)
- [GIT](https://git-scm.com/)
- [Composer](https://getcomposer.org/)
- [NodeJS](https://nodejs.org/)
- [NPM](https://www.npmjs.com/)
- [Grunt CLI](http://gruntjs.com/)
- [Blackfire](https://blackfire.io/)

## Image Processing Tools
- [ImageMagick](https://www.imagemagick.org/script/index.php)
- [GraphicsMagick](http://www.graphicsmagick.org/)

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