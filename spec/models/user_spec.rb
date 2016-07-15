describe User do
    
  it { should have_many :user_clan_relationships }
  it { should have_many :clans }
  it { should have_many :user_favour_relationships }
  it { should have_many :favours_for_me }
  it { should have_many :bids }
  it { should have_many :favours_bidded_on }
  
  context '#favours_to_bid_on' do
    it "builds an array of favours found in the user's clans that benefit other users" do
      user = User.create(username: 'Test', email: 'test@email.com', password_digest: '123456')
      
      favour1 = double(:favour, users_benefiting: [user,:user2])
      favour2 = double(:favour, users_benefiting: [user, :user3])
      favour3 = double(:favour, users_benefiting: [user])
      
      clan1 = double(:clan, favours: [favour1, favour2])
      clan2 = double(:clan, favours: [favour2, favour3])
      
      allow_any_instance_of(User).to receive(:clans).and_return([clan1,clan2])
      allow_any_instance_of(User).to receive(:favours_bidded_on).and_return([favour2])
     
      result = user.favours_to_bid_on
      
      expect(result).to eq [favour1]
    end
  end
    
end