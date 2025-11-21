const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://www.womendontoweyou.co.za';

export const trackPageVisit = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/track/page-visit`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
    });
    
    if (response.ok) {
      console.log('Page visit tracked');
    }
  } catch (error) {
    console.error('Error tracking page visit:', error);
  }
};

export const trackDonationClick = async (organizationName) => {
  try {
    const response = await fetch(`${API_BASE_URL}/track/donation-click`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        organization: organizationName
      }),
    });
    
    if (response.ok) {
      console.log(`Donation click tracked for ${organizationName}`);
    }
  } catch (error) {
    console.error('Error tracking donation click:', error);
  }
};
