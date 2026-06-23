import json
import boto3
import os

ses = boto3.client("ses")


def lambda_handler(event, context):

    record = event["Records"][0]

    bucket_name = record["s3"]["bucket"]["name"]
    file_name = record["s3"]["object"]["key"]

    sender_email = os.environ["SENDER_EMAIL"]
    receiver_email = os.environ["RECEIVER_EMAIL"]

    subject = "New File Uploaded"

    body = f"""
A new file has been uploaded.

Bucket: {bucket_name}

File: {file_name}
"""

    ses.send_email(
        Source=sender_email,
        Destination={
            "ToAddresses": [receiver_email]
        },
        Message={
            "Subject": {
                "Data": subject
            },
            "Body": {
                "Text": {
                    "Data": body
                }
            }
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps("Email sent")
    }