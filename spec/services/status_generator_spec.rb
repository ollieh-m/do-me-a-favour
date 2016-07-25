describe StatusGenerator do

  context '#forothers_status' do
    let(:current_user){ User.create(username: 'Test', email: 'test@email.com', password_digest: '123456') }
    let(:other_user){ User.create(username: 'Test2', email: 'test2@email.com', password_digest: '123456') }
    
    let(:favour1){ Favour.create(description: 'Test') }
    let(:favour2){ Favour.create(description: 'Test', completed: 'Confirmed') }
    
    let(:bid1){ double(:bid, accepted: nil) }
    let(:bid2){ double(:bid, accepted: nil) }
    let(:bid3){ double(:bid, accepted: true, user: current_user) }
    let(:bid4){ double(:bid, accepted: true, user: other_user) }
    
    it "returns 'awaiting response to your bid' if the favour has bids in but none have been accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid2])
      result = described_class.new(current_user).forothers_status(favour1)
      expect(result).to eq 'Awaiting response to your bid'
    end
    it "returns 'Your bid is accepted and awaiting fulfilment' if your bid is accepted but not completed" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = described_class.new(current_user).forothers_status(favour1)
      expect(result).to eq 'Your bid is accepted and awaiting fulfilment'
    end
    it "returns 'Nice one - you did this favour' if your bid is accepted and completed" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = described_class.new(current_user).forothers_status(favour2)
      expect(result).to eq 'Nice one - you did this favour'
    end
    it "returns 'Sorry, your bid was rejected' if another bid was accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid4])
      result = described_class.new(current_user).forothers_status(favour1)
      expect(result).to eq 'Sorry, your bid was rejected'
    end
  end
  
end