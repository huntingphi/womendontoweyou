#!/usr/bin/env python3
import requests
import random
import sys
from datetime import datetime

# Test main site via CloudFront
def test_main_site():
    try:
        response = requests.get('https://www.womendontoweyou.co.za', timeout=10)
        if response.status_code == 200 and 'GBV Support' in response.text:
            return True
    except:
        pass
    return False

# Test API via CloudFront
def test_donation_link():
    try:
        # Test API endpoint via CloudFront
        api_response = requests.post('https://www.womendontoweyou.co.za/track/donation-click', 
                                   json={'organization': 'test'}, timeout=5)
        if api_response.status_code == 200:
            return True
    except:
        pass
    return False

def main():
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    main_ok = test_main_site()
    api_ok = test_donation_link()
    
    status = "OK" if (main_ok and api_ok) else "FAIL"
    
    log_entry = f"[{timestamp}] Status: {status} | Main: {'OK' if main_ok else 'FAIL'} | API: {'OK' if api_ok else 'FAIL'}"
    
    print(log_entry)
    
    # Log to file
    with open('/home/ec2-user/canary.log', 'a') as f:
        f.write(log_entry + '\n')
    
    # Exit with error code if any test failed
    if not (main_ok and api_ok):
        sys.exit(1)

if __name__ == '__main__':
    main()
