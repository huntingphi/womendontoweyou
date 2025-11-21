# CloudFront Cleanup

## Unused Distributions

The following CloudFront distributions were created during development and are now disabled:

- **EN6H7YS0LA3JY** - "GBV Support Site CloudFront Distribution" (HTTPS-only origin)
- **EPVGQA3FA3HIB** - "GBV Support Site CloudFront Distribution - HTTP Origin"

## Active Distribution

- **E1CYWXAXNL73WW** - "GBV Support Site - Final with Custom Domain" 
  - Domain: www.womendontoweyou.co.za
  - Status: Active and in use

## Cleanup Commands

Once the disabled distributions show Status: "Deployed", they can be deleted:

```bash
# Delete first unused distribution
aws cloudfront delete-distribution --id EN6H7YS0LA3JY --if-match <etag>

# Delete second unused distribution  
aws cloudfront delete-distribution --id EPVGQA3FA3HIB --if-match <etag>
```

## Cost Savings

Removing unused distributions eliminates:
- Data transfer costs for unused endpoints
- Request charges for unused distributions
- Reduces management overhead

The active distribution (E1CYWXAXNL73WW) remains fully functional with the custom domain.
