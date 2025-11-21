# Building a Gender-Based Violence Support Site: From Idea to Production in One Session

*Published: November 21, 2025*

## The Context

Gender-based violence (GBV) is a critical issue in South Africa, with alarming statistics that demand urgent attention. While numerous organizations work tirelessly to combat this crisis, finding and supporting these organizations can be challenging for those who want to help. The fragmented landscape of support services makes it difficult for potential donors and supporters to discover and contribute to the cause effectively.

## The Problem

I identified several key challenges:

1. **Discoverability**: GBV support organizations in South Africa lack a centralized platform for visibility
2. **Donation friction**: Potential supporters struggle to find legitimate organizations to support
3. **Information scatter**: Contact details, emergency numbers, and resources are spread across multiple sources
4. **Trust barriers**: People need verified, legitimate organizations to feel confident about donating

The goal was simple: create a single, trustworthy platform that aggregates South African GBV support organizations, making it easy for people to discover and support them.

## The Solution

I built **Women Don't Owe You** - a React-based web application that serves as a centralized hub for South African organizations fighting gender-based violence. The solution includes:

### Core Features
- **Organization directory**: Curated list of 8 verified South African GBV organizations
- **Category filtering**: Filter organizations by type (Support Services, Crisis Intervention, etc.)
- **Direct donation links**: One-click access to each organization's donation page
- **Emergency contacts**: Quick access to critical helpline numbers
- **Responsive design**: Works seamlessly on mobile and desktop

### Technical Architecture
- **Frontend**: React application with modern, accessible UI
- **Backend**: Flask API for metrics tracking
- **Infrastructure**: AWS EC2 with nginx reverse proxy
- **CDN**: CloudFront distribution with custom domain and SSL
- **Monitoring**: CloudWatch metrics and automated health checks
- **Security**: Principle of least privilege, CloudFront-only access

## The Implementation

What made this project unique was building it entirely through AI-assisted development in a single session. Here's how it unfolded:

### Phase 1: Foundation (30 minutes)
- Created React application with organization data
- Implemented category filtering and responsive design
- Added emergency contact section with South African helplines
- Set up basic styling with accessibility considerations

### Phase 2: Backend & Metrics (45 minutes)
- Built Flask API with CloudWatch integration
- Implemented page visit and donation click tracking
- Created IAM user with minimal CloudWatch permissions
- Added metrics collection to React frontend

### Phase 3: Infrastructure (60 minutes)
- Launched EC2 instance with security group configuration
- Set up nginx reverse proxy for React and Flask
- Configured systemd services for auto-start on reboot
- Implemented SSL certificates for HTTPS support

### Phase 4: Production Deployment (45 minutes)
- Created CloudFront distribution for global CDN
- Configured custom domain with ACM SSL certificate
- Set up DNS routing to CloudFront endpoint
- Implemented automated health monitoring with cron jobs

### Phase 5: Security & Optimization (30 minutes)
- Restricted EC2 access to CloudFront IPs only
- Switched from React dev server to production static build
- Updated CloudFront to support POST requests for metrics
- Cleaned up unused resources and optimized costs

### Phase 6: Polish & Documentation (30 minutes)
- Added purple heart favicon and contact email
- Created comprehensive deployment documentation
- Set up GitHub repository with proper git authorship
- Implemented automated canary monitoring

## Technical Highlights

### Security-First Approach
The infrastructure implements defense in depth:
- EC2 instance only accessible via CloudFront (no direct public access)
- IAM user with minimal CloudWatch-only permissions
- Security groups restricting access to essential ports only
- HTTPS everywhere with proper SSL certificate management

### Cost Optimization
Monthly operational costs kept under $15:
- EC2 t2.micro instance (~$8.50)
- CloudFront distribution (~$1-5 depending on traffic)
- Minimal data transfer and storage costs
- No expensive load balancers or managed services

### Production-Ready Monitoring
- Automated health checks every 30 minutes
- CloudWatch metrics for page visits and donation tracking
- Systemd services with auto-restart capabilities
- Comprehensive logging and error tracking

### Scalable Architecture
The solution can easily scale:
- CloudFront handles global traffic distribution
- Static React build serves efficiently
- Flask API can scale horizontally with load balancers
- Database can be added without architectural changes

## Key Learnings

### AI-Assisted Development
This project demonstrated the power of AI-assisted development:
- **Rapid prototyping**: From idea to working prototype in minutes
- **Best practices**: AI suggested security and architectural improvements
- **Documentation**: Comprehensive docs generated alongside code
- **Troubleshooting**: Real-time problem solving and optimization

### Infrastructure as Code
While built interactively, the project emphasizes reproducibility:
- All configurations documented and version controlled
- One-command deployment script for easy replication
- Infrastructure decisions explained and justified
- Complete checkpoint file for project handover

### Social Impact Technology
Building for social causes requires different considerations:
- **Trust**: Users need confidence in organization legitimacy
- **Accessibility**: Must work for users with varying technical literacy
- **Reliability**: Downtime could prevent critical support connections
- **Cost efficiency**: Minimize operational costs to maximize impact

## The Results

**Live Site**: [https://www.womendontoweyou.co.za](https://www.womendontoweyou.co.za)  
**Source Code**: [https://github.com/huntingphi/womendontoweyou](https://github.com/huntingphi/womendontoweyou)

The platform successfully aggregates 8 major South African GBV organizations:
- TEARS Foundation
- Uyinene Foundation
- Rape Crisis Cape Town Trust
- Mosaic
- LifeLine Southern Africa
- Women and Men Against Child Abuse
- National Shelter Movement SA
- South African Depression and Anxiety Group

### Metrics & Impact
- Production-ready infrastructure with 99.9% uptime target
- Global CDN ensuring fast access from anywhere
- Automated monitoring preventing service disruptions
- Cost-effective operation under $15/month

## Future Enhancements

The platform provides a solid foundation for expansion:
- **More organizations**: Add regional and specialized GBV support groups
- **Resource library**: Include educational materials and guides
- **Volunteer matching**: Connect volunteers with organizations
- **Impact tracking**: Measure donation conversion and engagement
- **Multi-language support**: Serve South Africa's diverse language communities

## Conclusion

This project demonstrates how modern development practices, cloud infrastructure, and AI assistance can rapidly create meaningful social impact technology. In under 4 hours, we built a production-ready platform that addresses a real social need while maintaining professional standards for security, performance, and reliability.

The combination of React's modern frontend capabilities, AWS's robust infrastructure, and careful attention to user experience created a platform that serves both organizations seeking support and individuals wanting to help combat gender-based violence in South Africa.

Most importantly, the project shows that technical solutions for social problems don't require massive budgets or teams - sometimes the most impactful solutions are the simplest ones, executed well.

---

*The Women Don't Owe You platform is live at [www.womendontoweyou.co.za](https://www.womendontoweyou.co.za). The complete source code and deployment instructions are available on [GitHub](https://github.com/huntingphi/womendontoweyou).*

*If you're working on similar social impact projects or want to contribute to the platform, feel free to reach out or submit a pull request.*
