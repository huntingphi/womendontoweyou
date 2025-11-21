from flask import Flask, request, jsonify
from flask_cors import CORS
import boto3
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Configure AWS CloudWatch
cloudwatch = boto3.client(
    'cloudwatch',
    region_name=os.getenv('AWS_REGION', 'us-east-1'),
    aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
    aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY')
)

@app.route('/track/page-visit', methods=['POST'])
def track_page_visit():
    try:
        cloudwatch.put_metric_data(
            Namespace='GBV-Support-Site',
            MetricData=[
                {
                    'MetricName': 'PageVisits',
                    'Value': 1,
                    'Unit': 'Count',
                    'Timestamp': datetime.utcnow()
                }
            ]
        )
        return jsonify({'success': True})
    except Exception as e:
        print(f"Error tracking page visit: {e}")
        return jsonify({'success': False}), 500

@app.route('/track/donation-click', methods=['POST'])
def track_donation_click():
    try:
        data = request.get_json()
        organization = data.get('organization', 'Unknown')
        
        cloudwatch.put_metric_data(
            Namespace='GBV-Support-Site',
            MetricData=[
                {
                    'MetricName': 'DonationClicks',
                    'Value': 1,
                    'Unit': 'Count',
                    'Dimensions': [
                        {
                            'Name': 'Organization',
                            'Value': organization
                        }
                    ],
                    'Timestamp': datetime.utcnow()
                }
            ]
        )
        return jsonify({'success': True})
    except Exception as e:
        print(f"Error tracking donation click: {e}")
        return jsonify({'success': False}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
