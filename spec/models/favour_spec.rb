describe Favour do

  it { should have_many :favour_clan_relationships }
  it { should have_many :clans }
  
  context '#build_with' do
    it 'builds a new favour_clan_relationship associated with a new favour and the specified clans' do
      association_collection = spy(:association_collection)
      favour = double(:favour, favour_clan_relationships: association_collection)
      allow(Favour).to receive(:new).and_return(favour)
      
      Favour.build_with(clans: {'1'=>nil, '2'=>nil}, params: :params)
      expect(association_collection).to have_received(:build).with({clan_id: 1})
      expect(association_collection).to have_received(:build).with({clan_id: 2})
    end
  end
  
  context '#all_in_clans_of' do
    it "builds an array of favours found in the user's clans" do
      clan1 = double(:clan, favours: [:favour1, :favour2])
      clan2 = double(:clan, favours: [:favour2, :favour3])
      user = double(:user, clans: [clan1,clan2])
      
      result = Favour.all_in_clans_of(user: user)
      expect(result).to eq [:favour1,:favour2,:favour3]
    end
  end

end