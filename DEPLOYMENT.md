# Deployment Checklist

## 🚀 Basic EC2 Deployment

### 1. Prerequisites
- [ ] Amazon Linux 2023 EC2 instance (t3.small or larger)
- [ ] Security group with ports 22, 80, 443 open
- [ ] SSH key pair for access

### 2. Deploy Application
```bash
# Copy files to EC2
scp -r -i your-key.pem . ec2-user@YOUR-EC2-IP:/home/ec2-user/gbv-site/

# SSH and deploy
ssh -i your-key.pem ec2-user@YOUR-EC2-IP
cd gbv-site
./deploy.sh
```

### 3. Configure CloudWatch (Optional)
```bash
# Create IAM user with CloudWatch permissions
aws iam create-user --user-name gbv-site-metrics
aws iam create-policy --policy-name GBV-CloudWatch --policy-document file://config/cloudwatch-policy.json
aws iam attach-user-policy --user-name gbv-site-metrics --policy-arn arn:aws:iam::ACCOUNT:policy/GBV-CloudWatch
aws iam create-access-key --user-name gbv-site-metrics

# Update backend/.env with credentials
nano /opt/gbv-site/backend/.env
sudo systemctl restart gbv-flask
```

## 🌐 Production CloudFront Deployment

### 1. Set up Custom Domain
```bash
# Run CloudFront setup script
./scripts/setup-cloudfront.sh your-domain.com

# Follow DNS validation instructions
# Add final CNAME record to point domain to CloudFront
```

### 2. Verify Deployment
- [ ] Site accessible at https://your-domain.com
- [ ] SSL certificate valid (no browser warnings)
- [ ] Metrics flowing to CloudWatch
- [ ] Canary monitoring active

## 🔍 Monitoring & Maintenance

### Service Status
```bash
sudo systemctl status gbv-flask gbv-react nginx
```

### View Logs
```bash
# Application logs
sudo journalctl -u gbv-flask -f
sudo journalctl -u gbv-react -f

# Canary monitoring
tail -f /home/ec2-user/canary.log
```

### CloudWatch Metrics
- Navigate to AWS Console → CloudWatch → Custom Namespaces → `GBV-Support-Site`
- View `PageVisits` and `DonationClicks` metrics

## 🛠️ Troubleshooting

### Services Not Starting
```bash
# Check service status
sudo systemctl status gbv-flask gbv-react

# Restart services
sudo systemctl restart gbv-flask gbv-react

# Check logs for errors
sudo journalctl -u gbv-flask -n 50
```

### Site Not Accessible
```bash
# Check nginx status
sudo systemctl status nginx

# Test internal services
curl http://localhost:3000/
curl -X POST http://localhost:5000/track/page-visit
```

### CloudWatch Metrics Not Working
```bash
# Verify AWS credentials
cat /opt/gbv-site/backend/.env

# Test metrics manually
curl -X POST http://localhost:5000/track/page-visit

# Check Flask logs
sudo journalctl -u gbv-flask -n 20
```
