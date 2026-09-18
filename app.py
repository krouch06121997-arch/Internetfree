from flask import Flask

app = Flask(__name__)

@app.route('/health')
def health_check():
    return "OK, Server is running!", 200

@app.route('/')
def home():
    return "V2Ray WebSocket Server is running smoothly.", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
