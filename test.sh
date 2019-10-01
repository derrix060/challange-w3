#!/bin/bash

set -euxo pipefail

function wait_for_webapp_start {
    n=0
    until [ $n -ge 50 ]
    do
        docker-compose logs | grep "Running on http://0.0.0.0:5000/" && return 0
        n=$[$n+1]
        sleep 1
    done
    echo "Unable to start webapp"
    return 1
}

wait_for_webapp_start

# Check getting a wrong key
rtn=$(curl -v http://localhost:5001/key/wrong_key 2>&1)
echo $rtn | grep "HTTP/1.0 404 NOT FOUND"

# Test adding wrong value
rtn=$(curl -v -X PUT http://localhost:5000/key -H 'Content-Type: application/json' -d '{"wrong_key": "wrong_value"}' 2>&1)
echo $rtn | grep "HTTP/1.0 500 INTERNAL SERVER ERROR"

$ Test adding correct value
rtn=$(curl -v -X PUT http://localhost:5000/key -H 'Content-Type: application/json' -d '{"key": "key1", "value": "value2"}' 2>&1)
echo $rtn | grep "Pair \"{'key': 'key1', 'value': 'value2'}\" saved."
echo $rtn | grep "HTTP/1.0 202 ACCEPTED"

# Test quering correct value
rtn=$(curl -v http://localhost:5000/key/key1  2>&1)
echo $rtn | grep "HTTP/1.0 200 OK"
echo $rtn | grep '{"key": "key1", "value": "value2"}'
