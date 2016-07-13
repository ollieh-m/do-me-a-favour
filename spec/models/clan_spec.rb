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
  
  context '#all_except' do
    it 'returns all clans except those specified' do
      allow(Clan).to receive(:all).and_return([:clan1,:clan2,:clan3])
      result = Clan.all_except([:clan1,:clan2])
      expect(result).to eq [:clan3]
    end
  end
    
end