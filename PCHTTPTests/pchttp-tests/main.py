from flask import Flask
from flask import jsonify
from flask import request

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>', methods = ['GET', 'POST', 'PUT', 'DELETE'])
def catch_all(path):
    return jsonify(
        url = request.url,
        method = request.method,
        body = request.data
    )

if __name__ == "__main__":
    app.run(port = 5000, debug = True)