import unittest

import fakeredis

from challenge_w3 import api


class testClass(unittest.TestCase):

    def setUp(self):
        # Mocking redis
        api.db = fakeredis.FakeStrictRedis()
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

    def test_put_correct(self):
        self.headers.append(('Content-Length', len(self.valid_data)))
        rf = self.put(self.valid_data)
        self.assertEqual(rf.status_code, 202)

    def test_put_multiple_correct(self):
        self.test_put_correct()
        # Multiple calls should return 202.
        self.test_put_correct()

    def test_get_not_found(self):
        rf = self.get('invalid-key')
        self.assertEqual(rf.status_code, 404)

    def test_get_found(self):
        self.test_put_correct()
        rf = self.get('key1')
        self.assertEqual(rf.status_code, 200)
        self.assertEqual(rf.json, self.valid_data)
