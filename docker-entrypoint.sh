#!/bin/bash

if [ "$COUCHDB_SERVER_NAME" ] && [ "$COUCHDB_SERVER_PORT" ]; then
        fauxton -c http://$COUCHDB_SERVER_NAME:$COUCHDB_SERVER_PORT/
else
    if [ "`ping -c 1 couchdb`" ]
    then
        fauxton -c http://couchdb:5984/
    else
        echo "You need to set COUCHDB_SERVER_NAME and COUCHDB_SERVER_PORT ENV var"
    fi
fi