describe FavoursforothersDisplay do
  
  let(:user){ spy(:user) }
  
  let(:filter){ spy(:filter) }
  let(:biddable_filter){ double(:biddable_filter, new: filter) }
  
  let(:generator){ spy(:generator) }
  let(:status_generator){ double(:status_generator, new: generator) }

  let(:bid){ double(:bid, new: nil) }

  let(:favoursforothers_display){ described_class.new(user, biddable_filter, bid, status_generator) }
  
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
  context '#status' do
    it 'gets the forothers_status from a newly initialized status_generator' do
      favoursforothers_display.status(:favour)
      expect(generator).to have_received(:forothers_status).with(:favour)
    end
  end
end