describe FavoursforothersDisplay do
  
  let(:user){ spy(:user) }
  let(:filter){ spy(:filter) }
  let(:biddable_filter){ double(:biddable_filter, new: filter) }
  let(:bid){ double(:bid, new: nil) }
  let(:favoursforothers_display){ described_class.new(user, biddable_filter, bid) }
  
  context '#bidded_on' do
    it 'gets the favours the user has bidded on' do
      favoursforothers_display.bidded_on
      expect(user).to have_received(:favours_bidded_on)
    end
  end
  context '#biddable' do
    it 'gets the favours the user can bid on using the BiddableFilter' do
      favoursforothers_display.biddable
      expect(filter).to have_received(:favours)
    end
  end
  context '#new_bid' do
    it 'initializes a new bid' do
      favoursforothers_display.new_bid
      expect(bid).to have_received(:new)
    end
  end
end