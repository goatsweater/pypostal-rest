from flask import Flask, request
from flask_restful import Resource, Api
from flask_cors import CORS

from postal.expand import expand_address
from postal.parser import parse_address

app = Flask(__name__)
CORS(app)
api = Api(app)


class Parse(Resource):
    def get(self):
        query = request.args.get('query')
        parsed = parse_address(query)
        response = {key: value for (value, key) in parsed}
        return response

class Expand(Resource):
    def get(self):
        query = request.args.get('query')
        return expand_address(query)

api.add_resource(Parse, '/parse')
api.add_resource(Expand, '/expand')

if __name__ == '__main__':
    app.run(host='0.0.0.0')
