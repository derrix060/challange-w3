import redis

from flask import Flask
from flask import request
from flask import abort

app = Flask(__name__)
db = redis.Redis('w3-redis')


@app.errorhandler(Exception)
def error_handler(error):
    return str(error), 500


@app.route('/key', methods=['PUT'])
def put_key():
    pair = request.json
    print(pair)
    key = pair['key']
    value = pair['value']
    # Delete old keys.  Since there is no business logic involved in the
    # requirements, I'm assuming a duplicated key will have its value updated.
    if db.exists(key):
        db.delete(key)
    db.set(key, value)
    # On success reply a 202 status
    return 'Pair "{}" saved.\n'.format(pair), 202



@app.route('/key/<key>', methods=['GET'])
def get_key(key):
    # Return 404 when no data
    if not db.exists(key):
        return 'Key "{}" not found.'.format(key), 404
    print('getting value')
    value = db.get(key).decode()
    print(value)
    # Return key and value with a status code of 200.
    return '{"key": "%s", "value": "%s"}' % (key, value), 200

def main():
    app.run(debug=True, port=5000, host='0.0.0.0')


if __name__ == "__main__":
    main()
