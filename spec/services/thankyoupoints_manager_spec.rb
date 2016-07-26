describe ThankyoupointsManager do
  
  context '#exchange_thankyou_points' do
    
    let(:user1){ User.create(username: 'Testuser1', email: 'test1@email.com', password_digest: '123456', thankyoupoints: 100) }
    let(:user2){ User.create(username: 'Testuser2', email: 'test2@email.com', password_digest: '123456', thankyoupoints: 100) }
    let(:user3){ User.create(username: 'Testuser3', email: 'test3@email.com', password_digest: '123456', thankyoupoints: 100) }

    let(:bid){ double(:bid, accepted: true, user: user1, amount: 10) }
    let(:favour){ double(:favour, bids: [bid], users_benefiting: [user2, user3]) }
    
    let(:thankyoupoints_manager){ described_class.new(favour) }
    
    it "adds the bid's amount to the user who made the bid" do
      thankyoupoints_manager.exchange_thankyou_points
      expect(user1.thankyoupoints).to eq 110
    end
    it "subtracts an equal share of the bid's amount to the users benefiting from the favour" do
      thankyoupoints_manager.exchange_thankyou_points
      expect(user2.thankyoupoints).to eq 95
      expect(user3.thankyoupoints).to eq 95
    end
    
  end
  
end
