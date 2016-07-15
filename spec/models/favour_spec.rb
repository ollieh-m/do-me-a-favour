describe Favour do

  it { should have_many :favour_clan_relationships }
  it { should have_many :clans }
  it { should have_many :user_favour_relationships }
  it { should have_many :users_benefiting }
  it { should have_many :bids }

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
  
  context '#validate_with' do
    it "adds an error if clans is empty and returns false without saving" do
      favour = Favour.new(description:'Dummy description')
      result = favour.validate_with(clans:nil)
      expect(favour.errors).to eq ['You need to choose at least one clan']
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds an error if the initialized favour has no description and returns false without saving" do
      favour = Favour.new(description:'')
      result = favour.validate_with(clans:[:clan])
      expect(favour.errors).to eq ["Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds both errors if the initialized favour has no description and no clans are given" do
      favour = Favour.new(description:'')
      result = favour.validate_with(clans:nil)
      expect(favour.errors).to eq ['You need to choose at least one clan',"Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
  end
  
  context '#status' do
    let(:bid1){ double(:bid, accepted: nil) }
    let(:bid2){ double(:bid, accepted: nil) }
    let(:bid3){ double(:bid, accepted: true) }
    it "returns 'bids pending' if the favour has bids in but none have been accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid2])
      favour = Favour.create(description: 'Test')
      expect(favour.status).to eq 'Bids pending'
    end
    it "returns 'bid accepted' if the favour has bids in and one has been accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      favour = Favour.create(description: 'Test')
      expect(favour.status).to eq 'Bid accepted'
    end
    it "returns 'no bids' if the favour has no bids in" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([])
      favour = Favour.create(description: 'Test')
      expect(favour.status).to eq 'No bids'
    end
  end

end