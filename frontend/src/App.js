import React, { useState, useEffect } from 'react';
import './App.css';
import { trackPageVisit, trackDonationClick } from './metrics';

const organizations = [
  {
    id: 1,
    name: "Tears Foundation",
    description: "Provides support services to survivors of domestic violence and sexual abuse.",
    donateUrl: "https://tears.co.za/donate/",
    homeUrl: "https://tears.co.za/",
    category: "Support Services"
  },
  {
    id: 2,
    name: "Uyinene Foundation",
    description: "Works to promote gender equality and prevent gender-based violence.",
    donateUrl: "https://www.uyinenefoundation.co.za/#donate",
    homeUrl: "https://www.uyinenefoundation.co.za/",
    category: "Prevention"
  },
  {
    id: 3,
    name: "Rape Crisis Cape Town Trust",
    description: "Provides counselling and support services to survivors of sexual violence.",
    donateUrl: "https://rapecrisis.org.za/donate/",
    homeUrl: "https://rapecrisis.org.za/",
    category: "Support Services"
  },
  {
    id: 4,
    name: "Mosaic Training, Service and Healing Centre",
    description: "Offers trauma counselling and support for women and children affected by violence.",
    donateUrl: "https://mosaic.org.za/donate/",
    homeUrl: "https://mosaic.org.za/",
    category: "Counselling"
  },
  {
    id: 5,
    name: "Lifeline Southern Africa",
    description: "Provides crisis intervention and suicide prevention services.",
    donateUrl: "https://www.lifeline.org.za/Make-a-Donation.html",
    homeUrl: "https://www.lifeline.org.za/",
    category: "Crisis Support"
  },
  {
    id: 6,
    name: "Women and Men Against Child Abuse (WMACA)",
    description: "Focuses on preventing child abuse and supporting survivors.",
    donateUrl: "https://www.wmaca.org/how-to-help/",
    homeUrl: "https://www.wmaca.org/",
    category: "Child Protection"
  },
  {
    id: 7,
    name: "Nisaa Institute for Women's Development",
    description: "Provides support and advocacy for women and children affected by violence.",
    donateUrl: "https://www.nsmsa.org.za/donate/",
    homeUrl: "https://www.nsmsa.org.za/",
    category: "Support Services"
  },
  {
    id: 8,
    name: "South African Depression and Anxiety Group (SADAG)",
    description: "Provides mental health support and resources for those affected by trauma and violence.",
    donateUrl: "https://www.sadag.org/index.php?option=com_content&view=article&id=1896&Itemid=140",
    homeUrl: "https://www.sadag.org/",
    category: "Mental Health"
  }
];

const emergencyContacts = [
  { name: "GBV Command Centre", number: "0800 428 428" },
  { name: "SAPS Crime Stop", number: "08600 10111" },
  { name: "Childline", number: "116" }
];

function OrganizationCard({ org }) {
  const handleDonateClick = () => {
    trackDonationClick(org.name);
  };

  return (
    <div className="org-card">
      <h3>
        <a href={org.homeUrl} target="_blank" rel="noopener noreferrer" className="org-title-link">
          {org.name}
        </a>
      </h3>
      <span className="category">{org.category}</span>
      <p>{org.description}</p>
      <a 
        href={org.donateUrl} 
        target="_blank" 
        rel="noopener noreferrer" 
        className="donate-btn"
        onClick={handleDonateClick}
      >
        Donate Now
      </a>
    </div>
  );
}

function EmergencyCard({ contact }) {
  return (
    <div className="emergency-card">
      <h4>{contact.name}</h4>
      <p>{contact.number}</p>
    </div>
  );
}

function App() {
  const [filter, setFilter] = useState('All');
  
  // Track page visit when component mounts
  useEffect(() => {
    trackPageVisit();
  }, []);
  
  const categories = ['All', ...new Set(organizations.map(org => org.category))];
  
  const filteredOrgs = filter === 'All' 
    ? organizations 
    : organizations.filter(org => org.category === filter);

  return (
    <div className="App">
      <header>
        <h1>Support the Fight Against Gender-Based Violence</h1>
        <p>Help organizations working to end gender-based violence in South Africa</p>
      </header>

      <main>
        <div className="filter-section">
          <label>Filter by category: </label>
          <select value={filter} onChange={(e) => setFilter(e.target.value)}>
            {categories.map(category => (
              <option key={category} value={category}>{category}</option>
            ))}
          </select>
        </div>

        <div className="organizations-grid">
          {filteredOrgs.map(org => (
            <OrganizationCard key={org.id} org={org} />
          ))}
        </div>

        <section className="emergency-info">
          <h2>Emergency Contacts</h2>
          <div className="emergency-grid">
            {emergencyContacts.map((contact, index) => (
              <EmergencyCard key={index} contact={contact} />
            ))}
          </div>
        </section>
      </main>

      <footer>
        <p>Every donation makes a difference in the fight against gender-based violence.</p>
        <p><a href="mailto:womendontoweyou@protonmail.com">Contact Site Owner</a></p>
      </footer>
    </div>
  );
}

export default App;
