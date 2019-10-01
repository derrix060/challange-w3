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
[[ $(curl -s -o /dev/null -I -w "%{http_code}" http://localhost:5000/key/wrong_key) -eq 404 ]]

# Test adding wrong value
curl -v --silent -X PUT http://localhost:5000/key -H 'Content-Type: application/json' -d '{"wrong_key": "wrong_value"}' 2>&1 | grep "HTTP/1.0 500 INTERNAL SERVER ERROR"

$ Test adding correct value
[[ $(curl -X PUT http://localhost:5000/key -H 'Content-Type: application/json' -d '{"key": "key1", "value": "value2"}') == "Pair \"{'key': 'key1', 'value': 'value2'}\" saved." ]]

# Test quering correct value
[[ $(curl -s -o /dev/null -I -w "%{http_code}" http://localhost:5000/key/key1) -eq 200 ]]
[[ $(curl http://localhost:5000/key/key1) == '{"key": "key1", "value": "value2"}' ]]