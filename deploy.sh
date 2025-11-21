#!/bin/bash
set -e

echo "🚀 Deploying GBV Support Site..."

# Update system and install dependencies
sudo yum update -y
sudo yum install -y nodejs npm python3 python3-pip nginx cronie openssl

# Create app directory
sudo mkdir -p /opt/gbv-site
sudo chown -R ec2-user:ec2-user /opt/gbv-site

# Copy application files
cp -r frontend/* /opt/gbv-site/
cp -r backend /opt/gbv-site/

# Install Python dependencies
cd /opt/gbv-site/backend
pip3 install -r requirements.txt

# Install Gunicorn globally for systemd service
sudo pip3 install gunicorn==21.2.0

# Create log directory for Gunicorn
sudo mkdir -p /var/log
sudo touch /var/log/gunicorn-access.log /var/log/gunicorn-error.log
sudo chown root:root /var/log/gunicorn-*.log

# Install Node dependencies
cd /opt/gbv-site
npm install

# Create SSL certificate
sudo mkdir -p /etc/ssl/private /etc/ssl/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/gbv-site.key \
    -out /etc/ssl/certs/gbv-site.crt \
    -subj '/C=ZA/ST=Gauteng/L=Johannesburg/O=GBV Support/CN=localhost'

# Configure nginx
sudo cp config/nginx.conf /etc/nginx/conf.d/gbv-site.conf
sudo rm -f /etc/nginx/conf.d/default.conf

# Create systemd services
sudo cp config/gbv-flask.service /etc/systemd/system/
sudo cp config/gbv-react.service /etc/systemd/system/

# Set up canary monitoring
cp monitoring/canary.py /home/ec2-user/
chmod +x /home/ec2-user/canary.py

# Enable and start services
sudo systemctl daemon-reload
sudo systemctl enable nginx gbv-flask gbv-react crond
sudo systemctl start nginx gbv-flask gbv-react crond

# Set up cron job
(crontab -l 2>/dev/null; echo "*/30 * * * * /usr/bin/python3 /home/ec2-user/canary.py >> /home/ec2-user/canary.log 2>&1") | crontab -

echo "✅ Deployment complete!"
echo "📊 Site will be available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
echo "📝 Check logs: sudo journalctl -u gbv-flask -u gbv-react -f"
echo "🔍 Monitor: tail -f /home/ec2-user/canary.log"
