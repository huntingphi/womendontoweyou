#!/bin/bash
# CloudFront + Custom Domain Setup Script
# Usage: ./setup-cloudfront.sh your-domain.com

set -e

DOMAIN=$1
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 your-domain.com"
    exit 1
fi

echo "🌐 Setting up CloudFront for domain: $DOMAIN"

# Get EC2 public IP
EC2_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
EC2_DNS="ec2-${EC2_IP//./-}.compute-1.amazonaws.com"

echo "📍 EC2 Instance: $EC2_DNS"

# Request SSL certificate
echo "🔒 Requesting SSL certificate..."
CERT_ARN=$(aws acm request-certificate \
    --domain-name "$DOMAIN" \
    --validation-method DNS \
    --query 'CertificateArn' \
    --output text)

echo "📋 Certificate ARN: $CERT_ARN"

# Get validation record
echo "🔍 Getting DNS validation record..."
aws acm describe-certificate \
    --certificate-arn "$CERT_ARN" \
    --query 'Certificate.DomainValidationOptions[0].ResourceRecord' \
    --output table

echo ""
echo "📝 Add the DNS validation record above to your domain's DNS settings"
echo "⏳ Waiting for certificate validation..."

# Wait for certificate validation
while true; do
    STATUS=$(aws acm describe-certificate --certificate-arn "$CERT_ARN" --query 'Certificate.Status' --output text)
    if [ "$STATUS" = "ISSUED" ]; then
        echo "✅ Certificate validated!"
        break
    elif [ "$STATUS" = "FAILED" ]; then
        echo "❌ Certificate validation failed"
        exit 1
    fi
    echo "⏳ Status: $STATUS - waiting 30 seconds..."
    sleep 30
done

# Create CloudFront distribution
echo "☁️ Creating CloudFront distribution..."
cat > /tmp/cloudfront-config.json << EOF
{
    "CallerReference": "gbv-site-$(date +%s)",
    "Aliases": {
        "Quantity": 1,
        "Items": ["$DOMAIN"]
    },
    "DefaultRootObject": "",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "gbv-ec2-origin",
                "DomainName": "$EC2_DNS",
                "CustomOriginConfig": {
                    "HTTPPort": 80,
                    "HTTPSPort": 443,
                    "OriginProtocolPolicy": "http-only"
                }
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "gbv-ec2-origin",
        "ViewerProtocolPolicy": "redirect-to-https",
        "MinTTL": 0,
        "ForwardedValues": {
            "QueryString": true,
            "Cookies": {
                "Forward": "none"
            }
        },
        "TrustedSigners": {
            "Enabled": false,
            "Quantity": 0
        }
    },
    "CacheBehaviors": {
        "Quantity": 1,
        "Items": [
            {
                "PathPattern": "/track/*",
                "TargetOriginId": "gbv-ec2-origin",
                "ViewerProtocolPolicy": "redirect-to-https",
                "MinTTL": 0,
                "DefaultTTL": 0,
                "MaxTTL": 0,
                "ForwardedValues": {
                    "QueryString": true,
                    "Cookies": {
                        "Forward": "all"
                    }
                },
                "TrustedSigners": {
                    "Enabled": false,
                    "Quantity": 0
                }
            }
        ]
    },
    "Comment": "GBV Support Site - $DOMAIN",
    "Enabled": true,
    "ViewerCertificate": {
        "ACMCertificateArn": "$CERT_ARN",
        "SSLSupportMethod": "sni-only",
        "MinimumProtocolVersion": "TLSv1.2_2021"
    },
    "PriceClass": "PriceClass_100"
}
EOF

DISTRIBUTION=$(aws cloudfront create-distribution \
    --distribution-config file:///tmp/cloudfront-config.json \
    --query 'Distribution.[Id,DomainName]' \
    --output text)

DIST_ID=$(echo $DISTRIBUTION | cut -d' ' -f1)
DIST_DOMAIN=$(echo $DISTRIBUTION | cut -d' ' -f2)

echo "🎉 CloudFront distribution created!"
echo "📊 Distribution ID: $DIST_ID"
echo "🌐 CloudFront Domain: $DIST_DOMAIN"
echo ""
echo "📋 Final DNS Record to add:"
echo "Type: CNAME"
echo "Name: $DOMAIN"
echo "Value: $DIST_DOMAIN"
echo ""
echo "⏳ CloudFront deployment takes 10-15 minutes"
echo "🔗 Your site will be available at: https://$DOMAIN"

rm /tmp/cloudfront-config.json
