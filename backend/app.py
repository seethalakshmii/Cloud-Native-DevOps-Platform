from flask import Flask, jsonify
from database import get_connection
from prometheus_client import Counter, generate_latest
from prometheus_client import CONTENT_TYPE_LATEST

app = Flask(__name__)

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP Requests"
)


@app.route("/")
def home():

    REQUEST_COUNT.inc()

    return jsonify({
        "message": "Cloud Native DevOps Project"
    })


@app.route("/health")
def health():

    REQUEST_COUNT.inc()

    return jsonify({
        "status": "healthy"
    })


@app.route("/db-check")
def db_check():

    REQUEST_COUNT.inc()

    try:

        conn = get_connection()

        cursor = conn.cursor()

        cursor.execute("SELECT VERSION()")

        version = cursor.fetchone()

        cursor.close()
        conn.close()

        return jsonify({
            "database": "connected",
            "version": version[0]
        })

    except Exception as e:

        return jsonify({
            "database": "failed",
            "error": str(e)
        }), 500


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {
        "Content-Type": CONTENT_TYPE_LATEST
    }


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000
    )