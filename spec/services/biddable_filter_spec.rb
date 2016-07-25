describe BiddableFilter do

  context '#favours' do
    let(:user){ User.create(username: 'Test', email: 'test@email.com', password_digest: '123456') }
    subject(:filter){ described_class.new(user) }
   
    it "returns an array of favours found in the user's clans that benefit other users, have no accepted bids and haven't already got a bid from the user" do
      bid1 = double(:bid, accepted: nil)
      bid2 = double(:bid, accepted: true)
      
      favour1 = double(:favour, id: 1, bids: [bid1], users_benefiting: [user,:user2])
      favour2 = double(:favour, id: 2, bids: [bid1], users_benefiting: [user, :user3])
      favour3 = double(:favour, id: 3, bids: [bid1], users_benefiting: [user])
      favour4 = double(:favour, id: 4, bids: [bid1, bid2], users_benefiting: [user, :user2])
      
      clan1 = double(:clan, favours: [favour1, favour2, favour4])
      clan2 = double(:clan, favours: [favour2, favour3])
      
      allow_any_instance_of(User).to receive(:clans).and_return([clan1,clan2])
      allow_any_instance_of(User).to receive(:favours_bidded_on).and_return([favour2])
      allow(Favour).to receive(:where).with({id: [1,2,4,2,3]}).and_return([favour1,favour2,favour3,favour4])
     
      result = filter.favours
      
      expect(result).to eq [favour1]
    end
  end

end