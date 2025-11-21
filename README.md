# GBV Support Site - South Africa

A React-based website aggregating organizations fighting gender-based violence in South Africa, with CloudWatch metrics tracking.

## 🚀 Quick Deployment

### Prerequisites
- Amazon Linux 2023 EC2 instance
- Security group allowing ports 22, 80, 443
- SSH key pair for access

### Deploy to EC2

1. **Copy files to EC2:**
   ```bash
   scp -r -i your-key.pem . ec2-user@YOUR-EC2-IP:/home/ec2-user/gbv-site/
   ```

2. **SSH into instance and deploy:**
   ```bash
   ssh -i your-key.pem ec2-user@YOUR-EC2-IP
   cd gbv-site
   ./deploy.sh
   ```

3. **Configure CloudWatch credentials:**
   ```bash
   # Edit backend/.env with your AWS credentials
   nano /opt/gbv-site/backend/.env
   sudo systemctl restart gbv-flask
   ```

## 🏗️ Architecture

```
Internet → nginx (80/443) → React (3000) + Flask API (5000) → CloudWatch
```

## 📊 Features

- **React Frontend:** Organization listings with donation links
- **Flask Backend:** CloudWatch metrics API
- **Category Filtering:** Filter organizations by type
- **Emergency Contacts:** Quick access to help numbers
- **Monitoring:** Automated health checks every 30 minutes
- **SSL/HTTPS:** Self-signed certificates (production: use CloudFront + ACM)

## 🔧 Configuration

### Environment Variables
- `AWS_REGION`: AWS region for CloudWatch
- `AWS_ACCESS_KEY_ID`: CloudWatch metrics user
- `AWS_SECRET_ACCESS_KEY`: CloudWatch metrics secret

### Services
- `gbv-flask.service`: Flask backend (port 5000)
- `gbv-react.service`: React frontend (port 3000)
- `nginx`: Reverse proxy (ports 80/443)
- `crond`: Canary monitoring

## 📈 CloudWatch Setup

1. **Create IAM user** with CloudWatch PutMetricData permission
2. **Update credentials** in `backend/.env`
3. **View metrics** in AWS Console → CloudWatch → Custom Namespaces → `GBV-Support-Site`

## 🌐 Production Deployment

For production with custom domain:

1. **Set up CloudFront** distribution
2. **Request ACM certificate** for your domain
3. **Configure DNS** to point to CloudFront
4. **Update nginx** to serve over HTTP (CloudFront handles HTTPS)

## 📝 Monitoring

- **Health checks:** `/home/ec2-user/canary.log`
- **Service logs:** `sudo journalctl -u gbv-flask -u gbv-react -f`
- **CloudWatch metrics:** Page visits and donation clicks

## 🛠️ Development

### Local Development
```bash
# Backend
cd backend
pip3 install -r requirements.txt
python3 app.py

# Frontend
cd frontend
npm install
npm start
```

### Adding Organizations
Edit `frontend/src/App.js` and add to the `organizations` array:

```javascript
{
  id: 9,
  name: "Organization Name",
  description: "Description of the organization",
  donateUrl: "https://example.org/donate/",
  homeUrl: "https://example.org/",
  category: "Support Services"
}
```

## 📞 Emergency Contacts

- **GBV Command Centre:** 0800 428 428
- **SAPS Crime Stop:** 08600 10111  
- **Childline:** 116

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test deployment on EC2
5. Submit a pull request

## 📄 License

This project is dedicated to supporting organizations fighting gender-based violence in South Africa.
