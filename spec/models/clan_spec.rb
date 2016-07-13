describe Clan do
    
  it { should have_many :user_clan_relationships }
  it { should have_many :users }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  
  context '#build_with' do
    it 'builds a new user_clan_relationship associated with a new clan and the specified user' do
      association_collection = spy(:association_collection)
      clan = double(:clan, user_clan_relationships: association_collection)
      allow(Clan).to receive(:new).and_return(clan)
      
      Clan.build_with(user: :user, params: :params)
      expect(association_collection).to have_received(:build).with({user: :user})
    end
  end
    
end