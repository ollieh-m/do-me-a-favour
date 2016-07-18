describe Bid do
   
  it { should belong_to :user }
  it { should belong_to :favour }
  
  context '#validate' do
    it 'should save the bid successfully if the user can bid on the favour' do
      favour = Favour.create(description: 'Test')
      user = User.create(username: 'Test', email: 'test@email.com', password_digest: '123456')
      allow_any_instance_of(User).to receive(:favours_to_bid_on).and_return([favour])
      bid = Bid.new(user: user, favour: favour)
      expect(bid.validate).to eq true
      expect(Bid.all.count).to eq 1
    end
    it 'should not save the bid successfully if the user cannot bid on the favour' do
      favour = Favour.create(description: 'Test')
      user = User.create(username: 'Test', email: 'test@email.com', password_digest: '123456')
      allow_any_instance_of(User).to receive(:favours_to_bid_on).and_return([])
      bid = Bid.new(user: user, favour: favour)
      expect(bid.validate).to eq false
      expect(Bid.all.count).to eq 0
      expect(bid.errors).to eq ['You can only bid on a favour posted to one of your clans that other users will benefit from']
    end
  end
    
end