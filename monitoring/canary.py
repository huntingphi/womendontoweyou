#!/usr/bin/env python3
import requests
import random
import sys
from datetime import datetime

# List of donation URLs to test
donation_urls = [
    'https://tears.co.za/donate/',
    'https://www.uyinenefoundation.co.za/#donate',
    'https://rapecrisis.org.za/donate/',
    'https://mosaic.org.za/donate/',
    'https://www.lifeline.org.za/Make-a-Donation.html',
    'https://www.wmaca.org/how-to-help/',
    'https://www.nsmsa.org.za/donate/',
    'https://www.sadag.org/index.php?option=com_content&view=article&id=1896&Itemid=140'
]

def test_site():
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    try:
        # Test main site via CloudFront
        response = requests.get('https://www.womendontoweyou.co.za/', timeout=10)
        if response.status_code == 200:
            print(f'{timestamp} - Main site OK (200)')
        else:
            print(f'{timestamp} - Main site ERROR ({response.status_code})')
            return False
            
        # Test random donation link
        random_url = random.choice(donation_urls)
        response = requests.get(random_url, timeout=10)
        if response.status_code == 200:
            print(f'{timestamp} - Donation link OK: {random_url}')
        else:
            print(f'{timestamp} - Donation link ERROR ({response.status_code}): {random_url}')
            
        return True
        
    except Exception as e:
        print(f'{timestamp} - ERROR: {str(e)}')
        return False

if __name__ == '__main__':
    test_site()
