describe Favour do

  it { should have_many :favour_clan_relationships }
  it { should have_many :clans }
  it { should have_many :user_favour_relationships }
  it { should have_many :users_benefiting }
  it { should have_many :bids }

  context '#build_with' do
    let(:clans_association_collection){spy(:association_collection)}
    let(:users_association_collection){spy(:association_collection)}
    let(:favour){double(:favour, clans: clans_association_collection, users_benefiting: users_association_collection)}
    
    it 'initializes a favour and adds the specified clans into the favour.clans collection' do
      clans = [:dummy_clan_1,:dummy_clan_2]
      allow(Favour).to receive(:new).and_return(favour)
      
      Favour.build_with(:dummy_users_benefiting, clans, :dummy_favour_params)
      
      expect(clans_association_collection).to have_received(:<<).with(clans)
    end
    it 'initializes a favour and adds the specified users into the favour.users_benefiting collection' do
      users_benefiting = [:dummy_user_1,:dummy_user_2]
      allow(Favour).to receive(:new).and_return(favour)
      
      Favour.build_with(users_benefiting, :dummy_clans, :dummy_favour_params)
      
      expect(users_association_collection).to have_received(:<<).with(users_benefiting)
    end
  end
  
  context '#validate' do
    it "adds an error if clans is empty and returns false without saving" do
      favour = Favour.new(description:'Dummy description')
      allow_any_instance_of(Favour).to receive(:clans).and_return []
      
      result = favour.validate
      
      expect(favour.errors).to eq ['You need to choose at least one clan']
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds an error if the initialized favour has no description and returns false without saving" do
      favour = Favour.new(description:'')
      allow_any_instance_of(Favour).to receive(:clans).and_return [:dummy_clans]
      
      result = favour.validate
      
      expect(favour.errors).to eq ["Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
    it "adds both errors if the initialized favour has no description and no clans are given" do
      favour = Favour.new(description:'')
      allow_any_instance_of(Favour).to receive(:clans).and_return []
      
      result = favour.validate
      
      expect(favour.errors).to eq ['You need to choose at least one clan',"Description can't be blank"]
      expect(Favour.all.count).to eq 0
      expect(result).to eq false
    end
  end
  
  context '#validate_completion_with' do
    it 'saves the updated favour if the favour benefits the specified user' do
      favour = Favour.new(description: 'Test', completed: 'Confirmed')
      user = double(:user)
      allow_any_instance_of(Favour).to receive(:users_benefiting).and_return([user])
      result = favour.validate_completion_with(user: user)
      expect(result).to eq true
      expect(Favour.all.count).to eq 1
    end
    it 'saves the updated favour if the favour benefits the specified user' do
      favour = Favour.new(description: 'Test', completed: 'Confirmed')
      user = double(:user)
      allow_any_instance_of(Favour).to receive(:users_benefiting).and_return([])
      result = favour.validate_completion_with(user: user)
      expect(result).to eq false
      expect(Favour.all.count).to eq 0
    end
  end
  
  context '#formeindex_status' do
    let(:favour1){ Favour.create(description: 'Test') }
    let(:favour2){ Favour.create(description: 'Test', completed: 'Confirmed') }
    
    let(:bid1){ double(:bid, accepted: nil) }
    let(:bid2){ double(:bid, accepted: nil) }
    let(:bid3){ double(:bid, accepted: true) }

    it "returns 'Bids in waiting on your response' if the favour has bids in but none have been accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid2])
      result = favour1.formeindex_status
      expect(result).to eq 'Bids in waiting on your response'
    end
    it "returns 'A bid has been accepted for this favour' if a bid is accepted but not complete" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = favour1.formeindex_status
      expect(result).to eq 'A bid has been accepted for this favour'
    end
    it "returns 'This favour has been carried out' if a favour is complete" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = favour2.formeindex_status
      expect(result).to eq 'This favour has been carried out'
    end
  end

end