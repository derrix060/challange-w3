import unittest

from challenge_w3 import api


class testClass(unittest.TestCase):

    def setUp(self):
        # Tell flask to create a test client.
        self.app = api.app.test_client()
        self.headers = [('Content-Type', 'application/json')]
        self.valid_data = '{"key": key1", "value": "value1"}'

    def put(self, data):
        return self.app.put('/key', headers=self.headers, data=data)

    def get(self, key):
        return self.app.get('/key/{}'.format(key))

    def test_put_blank(self):
        data = "{}"
        self.headers.append(('Content-Length', len(data)))
        rf = self.put(data)
        self.assertEqual(rf.status_code, 500)

    def test_put_wrong(self):
        data = "{wrong}"
        self.headers.append(('Content-Length', len(data)))
        rf = self.put(data)
        self.assertEqual(rf.status_code, 500)

    def test_put_wrong_content_type(self):
        self.headers = [('Content-Type', 'application/xml')]
        self.headers.append(('Content-Length', len(self.valid_data)))
        rf = self.put(self.valid_data)
        self.assertEqual(rf.status_code, 500)

    # TODO: check how to mock redis.
    # def test_get_not_found(self):
    #     rf = self.get('invalid-key')
    #     self.assertEqual(rf.status_code, 404)

    # def test_put_correct(self, mock_redis_get, mock_redis_set):
    #     mock_redis_get.side_effect = api.db.get
    #     mock_redis_set.side_effect = api.db.set
    #     self.headers.append(('Content-Length', len(self.valid_data)))
    #     rf = self.put(self.valid_data)
    #     self.assertEqual(rf.status_code, 202)

    # def test_put_multiple_correct(self):
    #     self.test_put_correct()
    #     # Multiple calls should return 202.
    #     self.test_put_correct()

    # def test_get_found(self):
    #     self.test_put_correct()
    #     rf = self.get('key1')
    #     self.assertEqual(rf.status_code, 200)
    #     self.assertEqual(rf.json, self.valid_data)
