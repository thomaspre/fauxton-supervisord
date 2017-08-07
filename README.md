# Docker Fauxton Supervisord

Supervisord start the fauxton serveur with docker couchdb endpoint
By default fauxton listening on 8000

## CouchDB server configuration

You can specify CouchDB host in the `COUCHDB_SERVER_NAME` environment variable. You can also
use `COUCHDB_SERVER_PORT` to specify port of the server.

* ``COUCHDB_SERVER_NAME`` - Host name of couchdb service
* ``COUCHDB_SERVER_PORT`` - Port of couchdb service

## docker compose example

```
  fauxton:
    image: thomaspre/fauxton-supervisord
    ports:
        - 8000:8000
    volumes:
      - ./docker-log/fauxton:/var/log/supervisor
    environement:
        - COUCHDB_SERVER_NAME=couchdb
        - COUCHDB_SERVER_PORT=5984
```

Then open http://127.0.0.1:8000/ to see fauxton interface

## Nginx revers proxy configuration

You can use an nginx revers proxy with this example vhost :

```
server {
    listen   80;
    server_name fauxton.domain.com;
    set $backend "http://fauxton:8000"; #fauxton is the docker host name witch is running fauxton, 8000 defaut port fauxton listening

    error_log /var/log/supervisor/fauxton-error.log error;
    access_log /var/log/supervisor/fauxton-access.log main;

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    location ~* {
        proxy_pass_request_headers on;
        more_set_headers 'WWW-Authenticate : Basic realm="administrator"';

        proxy_set_header X-Real-IP  $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_set_header Host $host;
        proxy_pass $backend;
    }
}
```

Remove ports line in compose file in this configuration