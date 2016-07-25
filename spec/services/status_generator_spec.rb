describe StatusGenerator do

  context '#forotherspage_favour_status' do
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
      result = described_class.new(current_user).forotherspage_favour_status(favour1)
      expect(result).to eq 'Awaiting response to your bid'
    end
    it "returns 'Your bid is accepted and awaiting fulfilment' if your bid is accepted but not completed" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = described_class.new(current_user).forotherspage_favour_status(favour1)
      expect(result).to eq 'Your bid is accepted and awaiting fulfilment'
    end
    it "returns 'Nice one - you did this favour' if your bid is accepted and completed" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = described_class.new(current_user).forotherspage_favour_status(favour2)
      expect(result).to eq 'Nice one - you did this favour'
    end
    it "returns 'Sorry, your bid was rejected' if another bid was accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid4])
      result = described_class.new(current_user).forotherspage_favour_status(favour1)
      expect(result).to eq 'Sorry, your bid was rejected'
    end
  end
  
  context '#formepage_favour_status' do
    let(:favour1){ Favour.create(description: 'Test') }
    let(:favour2){ Favour.create(description: 'Test', completed: 'Confirmed') }
    
    let(:bid1){ double(:bid, accepted: nil) }
    let(:bid2){ double(:bid, accepted: nil) }
    let(:bid3){ double(:bid, accepted: true) }
    
    let(:status_generator){ described_class.new }

    it "returns 'Bids in waiting on your response' if the favour has bids in but none have been accepted" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid2])
      result = status_generator.formepage_favour_status(favour1)
      expect(result).to eq 'Bids in waiting on your response'
    end
    it "returns 'A bid has been accepted for this favour' if a bid is accepted but not complete" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = status_generator.formepage_favour_status(favour1)
      expect(result).to eq 'A bid has been accepted for this favour'
    end
    it "returns 'This favour has been carried out' if a favour is complete" do
      allow_any_instance_of(Favour).to receive(:bids).and_return([bid1,bid3])
      result = status_generator.formepage_favour_status(favour2)
      expect(result).to eq 'This favour has been carried out'
    end
  end
  
end