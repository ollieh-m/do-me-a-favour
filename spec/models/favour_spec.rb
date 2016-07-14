describe Favour do

  it { should have_many :favour_clan_relationships }
  it { should have_many :clans }
  it { should have_many :user_favour_relationships }
  it { should have_many :users_benefiting }
  it { should validate_presence_of(:description) }
  
  context '#build_with' do
    it 'builds a new favour_clan_relationship associated with a new favour and the specified clans' do
      association_collection = spy(:association_collection)
      favour = double(:favour, favour_clan_relationships: association_collection)
      allow(Favour).to receive(:new).and_return(favour)
      
      Favour.build_with(users_benefiting: nil,clans: {'1'=>nil, '2'=>nil}, params: :params)
      expect(association_collection).to have_received(:build).with({clan_id: 1})
      expect(association_collection).to have_received(:build).with({clan_id: 2})
    end
    it 'builds a new user_favour_relationship associated with a new favour and the specified users' do
      association_collection = spy(:association_collection)
      favour = double(:favour, user_favour_relationships: association_collection)
      allow(Favour).to receive(:new).and_return(favour)
      
      Favour.build_with(users_benefiting: [:user1,:user2],clans: nil,params: :params)
      expect(association_collection).to have_received(:build).with({user: :user1})
      expect(association_collection).to have_received(:build).with({user: :user2})
    end
  end
  
  context '#all_benefiting_others_and_in_clans_of' do
    it "builds an array of favours found in the user's clans that benefit other users" do
      user = double(:user)
      favour1 = double(:favour, users_benefiting: [user,:user2])
      favour2 = double(:favour, users_benefiting: [user, :user3])
      favour3 = double(:favour, users_benefiting: [user])
      clan1 = double(:clan, favours: [favour1, favour2])
      clan2 = double(:clan, favours: [favour2, favour3])
      allow(user).to receive(:clans).and_return([clan1,clan2])
      
      result = Favour.all_benefiting_others_and_in_clans_of(user: user)
      
      expect(result).to eq [favour1,favour2]
    end
  end
  
  context '#validate_given' do
    it "adds an error if clans is empty and returns false without saving" do
      favour = Favour.new(description:'Dummy description')
      result = favour.validate_given(clans:nil)
      expect(favour.errors).to eq ['You need to choose at least one clan']
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds an error if the initialized favour has no description and returns false without saving" do
      favour = Favour.new(description:'')
      result = favour.validate_given(clans:[:clan])
      expect(favour.errors).to eq ["Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds both errors if the initialized favour has no description and no clans are given" do
      favour = Favour.new(description:'')
      result = favour.validate_given(clans:nil)
      expect(favour.errors).to eq ['You need to choose at least one clan',"Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
  end

end