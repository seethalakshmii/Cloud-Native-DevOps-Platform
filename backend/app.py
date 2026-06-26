from flask import Flask, request, jsonify
from database import get_connection
import boto3
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)

# AWS Configuration
AWS_REGION = os.getenv("AWS_REGION", "us-west-1")
S3_BUCKET = os.getenv("S3_BUCKET")

s3 = boto3.client("s3", region_name=AWS_REGION)


# -------------------------
# HOME
# -------------------------
@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "Cloud Native DevOps Project"
    })


# -------------------------
# HEALTH
# -------------------------
@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy"
    })


# -------------------------
# SAVE TO RDS
# -------------------------
@app.route("/submit", methods=["POST"])
def submit():

    try:

        data = request.get_json()

        if not data:
            return jsonify({"error": "No JSON received"}), 400

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            """
            INSERT INTO users(name,email,message)
            VALUES(%s,%s,%s)
            """,
            (
                data["name"],
                data["email"],
                data["message"]
            )
        )

        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({
            "message": "Saved to RDS successfully"
        })

    except Exception as e:

        return jsonify({
            "error": str(e)
        }), 500


# -------------------------
# GET USERS
# -------------------------
@app.route("/users", methods=["GET"])
def users():

    try:

        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM users")

        rows = cursor.fetchall()

        cursor.close()
        conn.close()

        users = []

        for row in rows:

            users.append({
                "id": row[0],
                "name": row[1],
                "email": row[2],
                "message": row[3]
            })

        return jsonify(users)

    except Exception as e:

        return jsonify({
            "error": str(e)
        }), 500


# -------------------------
# UPLOAD FILE TO S3
# -------------------------
@app.route("/upload", methods=["POST"])
def upload():

    try:

        if "file" not in request.files:
            return jsonify({
                "error": "No file selected"
            }), 400

        file = request.files["file"]

        if file.filename == "":
            return jsonify({
                "error": "Empty filename"
            }), 400

        filename = secure_filename(file.filename)

        s3.upload_fileobj(
            file,
            S3_BUCKET,
            filename
        )

        return jsonify({
            "message": f"{filename} uploaded successfully to S3"
        })

    except Exception as e:

        return jsonify({
            "error": str(e)
        }), 500


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000
    )