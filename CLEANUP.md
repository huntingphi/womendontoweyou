# Infrastructure Cleanup

## CloudFront Distributions ✅ DONE

The following CloudFront distributions were created during development and are now disabled:

- **EN6H7YS0LA3JY** - "GBV Support Site CloudFront Distribution" (HTTPS-only origin) - DISABLED
- **EPVGQA3FA3HIB** - "GBV Support Site CloudFront Distribution - HTTP Origin" - DISABLED

### Active Distribution
- **E1CYWXAXNL73WW** - "GBV Support Site - Final with Custom Domain" 
  - Domain: www.womendontoweyou.co.za
  - Status: Active and in use

### Cleanup Commands
Once the disabled distributions show Status: "Deployed", they can be deleted:

```bash
# Delete first unused distribution
aws cloudfront delete-distribution --id EN6H7YS0LA3JY --if-match <etag>

# Delete second unused distribution  
aws cloudfront delete-distribution --id EPVGQA3FA3HIB --if-match <etag>
```

## Server Cleanup ✅ DONE

- **Temporary files**: Removed unused React component files from /tmp/
- **Systemd services**: Removed unused gbv-react.service file
- **Production setup**: React development server disabled, static files served by nginx

## Resources to Keep

### EC2 Instances
- **i-08e55b92381e88fbd** (GBV-Support-Site) - ACTIVE - Keep running

### Security Groups  
- **sg-0dc4491bd034e3752** (gbv-site-sg) - ACTIVE - In use by EC2 instance

### Key Pairs
- **gbv-site-key-new** - ACTIVE - Required for server access

### IAM Users
- **gbv-site-metrics** - ACTIVE - Required for CloudWatch metrics

## Potential Future Cleanup

### Stopped EC2 Instances (Consider terminating if unused)
- **i-019be4bb9ee815af4** (None) - stopped
- **i-0ba0e79963903c712** (iranasignalproxy) - stopped  
- **i-0c3f2cfad6f47f373** (22sevenReporter) - stopped

### Unused Security Groups (Safe to delete if no instances use them)
- **sg-08acdacabfdbf212d** (launch-wizard-2)
- **sg-012152576847c9d5b** (launch-wizard-1)
- **sg-08861d25e75bdc090** (OpenVPN Access Server)

### Unused Key Pairs (Delete if no longer needed)
- **openvpnserver** - If OpenVPN no longer used
- **iranasignalproxy** - If proxy no longer used
- **mba13** - If old laptop access no longer needed

### Unused IAM Users (Review access)
- **personal** - Review if still needed
- **voice-to-note** - Review if still needed

## Cost Optimization Summary

✅ **Completed optimizations:**
- Disabled 2 unused CloudFront distributions
- Switched from React dev server to production static files
- Cleaned up temporary server files
- Removed unused systemd services

💰 **Estimated monthly savings:** ~$5-10 from unused CloudFront distributions
