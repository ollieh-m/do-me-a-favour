describe User do
    
  it { should have_many :user_clan_relationships }
  it { should have_many :clans }
  it { should have_many :user_favour_relationships }
  it { should have_many :favours_for_me }
  it { should have_many :bids }
  it { should have_many :favours_bidded_on }
    
end