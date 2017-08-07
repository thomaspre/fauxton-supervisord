# fauxton-supervisord

Serveur timezone is set to Europe/Paris

Supervisord start the fauxton serveur with docker couchdb endpoint

By default fauxton listening on 8000

You need to give this parameters by environement vairables on docker start :

COUCHDB_SERVER_NAME : Host name of couchdb service
COUCHDB_SERVER_PORT : Port of couchdb service

You can make an nginx revers proxy with this vhost :
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