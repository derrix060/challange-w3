# challange-w3

## How to use
TODO

## Challenge

### Mini Rest API (api.py)
Write a python3 script that starts up a RESTfull application and listen to HTTP request on port 5000. Use redis to store data.
You must create two endpoints /key and /key/<KEY> which support two verbs:
- PUT /key: create a redis key with the key/value coming from the body. The below command must have the similar output than `redis-cli set key1 value1`.
    - `curl -XPUT http://localhost:5000/key -H 'content-type: application/json' -d '{"key": "key1", "value": "value1"}'`. On success reply a 202 status and 500 in case of an error.
- GET /key/<KEY>: will retrieve the key name and value in the following json format: `'{"key": "key1", "value": "value1"}'` with a status code of 200. If the key can not be found
you must reply a 404 with no data.

### Dockerfile

- Create a Dockerfile which is running the project created.
- Create a docker-compose file which will allow us to bring the project up. We should be able to query the api via http://localhost:5000. Redis must not run in the same container
the python project

### Terraform
- Create a terraform directory which will contain the configuration files and bring the project live into Amazon ECS (Using remote state file).
