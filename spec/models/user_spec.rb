describe User do
    
  it { should have_many :user_clan_relationships }
  it { should have_many :clans }
    
end