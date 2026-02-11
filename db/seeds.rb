# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

partners_data = [
  {
    name: "Figure",
    rating: 4.8,
    min_loan: "$15,000",
    max_loan: "$400,000",
    apr_from: "6.49%",
    url: "https://www.figure.com/",
    best_for: "Tech-savvy homeowners seeking speed",
    features: ["100% online process", "Fast 5-day funding", "No appraisal required"],
    why_matched: nil,
    credit_tier: [],
    specialties: [],
    match_score: nil,
    position: 1
  },
  {
    name: "Wells Fargo",
    rating: 4.8,
    min_loan: "$25,000",
    max_loan: "$500,000",
    apr_from: "6.99%",
    url: "https://www.wellsfargo.com/home-equity/",
    best_for: "Existing customers and large loan amounts",
    features: ["No closing costs", "Online account management", "Relationship discounts"],
    why_matched: "Best rates for your equity amount",
    credit_tier: ["740+"],
    specialties: ["Home Renovation", "Investment Property"],
    match_score: 92,
    position: 2
  },
  {
    name: "Bank of America",
    rating: 4.7,
    min_loan: "$25,000",
    max_loan: "$500,000",
    apr_from: "7.25%",
    url: "https://www.bankofamerica.com/home-loans/home-equity-loans/",
    best_for: "Rewards program members",
    features: ["Preferred Rewards discounts", "Mobile app access", "No annual fee"],
    why_matched: "No annual fee and mobile-first experience",
    credit_tier: ["740+", "670-739"],
    specialties: ["Home Renovation", "Education Expenses"],
    match_score: 88,
    position: 3
  },
  {
    name: "Chase",
    rating: 4.9,
    min_loan: "$25,000",
    max_loan: "$500,000",
    apr_from: "7.15%",
    url: "https://www.chase.com/personal/home-equity",
    best_for: "Quick funding needs",
    features: ["Fast approval process", "Premier banking benefits", "Rate lock options"],
    why_matched: "Fast approval process matches your immediate timeframe",
    credit_tier: ["740+", "670-739"],
    specialties: ["Immediately", "Within 30 days", "Debt Consolidation"],
    match_score: 95,
    position: 4
  },
  {
    name: "US Bank",
    rating: 4.6,
    min_loan: "$15,000",
    max_loan: "$750,000",
    apr_from: "7.40%",
    url: "https://www.usbank.com/home-loans/home-equity-loans-and-lines-of-credit.html",
    best_for: "Smaller loan amounts and financial guidance",
    features: ["Lower minimum loan", "Flexible terms", "Free financial planning"],
    why_matched: "Works with a wider range of credit profiles",
    credit_tier: ["670-739", "580-669"],
    specialties: ["Debt Consolidation", "Emergency Fund"],
    match_score: 85,
    position: 5
  },
  {
    name: "PNC Bank",
    rating: 4.7,
    min_loan: "$25,000",
    max_loan: "$500,000",
    apr_from: "7.30%",
    url: "https://www.pnc.com/en/personal-banking/borrowing/home-lending/home-equity.html",
    best_for: "Digital-first experience",
    features: ["Virtual wallet integration", "No prepayment penalty", "Customer support 24/7"],
    why_matched: "Virtual wallet integration and 24/7 support",
    credit_tier: ["740+", "670-739"],
    specialties: ["Just exploring", "Within 60 days"],
    match_score: 87,
    position: 6
  },
  {
    name: "Regions Bank",
    rating: 4.5,
    min_loan: "$10,000",
    max_loan: "$500,000",
    apr_from: "7.50%",
    url: "https://www.regions.com/personal-banking/loans/home-equity-line-of-credit",
    best_for: "First-time HELOC borrowers",
    features: ["Lowest minimum loan", "Regional expertise", "Personalized service"],
    why_matched: "Lowest minimum loan amount and personalized service",
    credit_tier: ["670-739", "580-669", "below-580"],
    specialties: ["Other", "Emergency Fund"],
    match_score: 82,
    position: 7
  }
]

partners_data.each_with_index do |attrs, idx|
  partner = Partner.find_or_initialize_by(name: attrs[:name])
  partner.assign_attributes(attrs)
  partner.save!
end
