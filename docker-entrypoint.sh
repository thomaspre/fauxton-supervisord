#!/bin/bash

if [ "$COUCHDB_SERVER_NAME" ] && [ "$COUCHDB_SERVER_PORT" ]; then
    echo "Fauxton will use http://$COUCHDB_SERVER_NAME:$COUCHDB_SERVER_PORT/ server"
    fauxton -c http://$COUCHDB_SERVER_NAME:$COUCHDB_SERVER_PORT/
else
    if [ "`ping -c 1 couchdb`" ]
    then
        echo "Fauxton can ping couchdb host, it will start with http://couchdb:5984/ couchdb server link"
        fauxton -c http://couchdb:5984/
    else
        echo >&2 "You need to set COUCHDB_SERVER_NAME and COUCHDB_SERVER_PORT ENV var"
    fi
fi