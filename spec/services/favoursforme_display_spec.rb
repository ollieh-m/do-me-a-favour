describe FavoursformeDisplay do
    
  let(:user){ spy(:user) }
  
  let(:generator){ spy(:generator) }
  let(:status_generator){ double(:status_generator, new: generator) }

  let(:favoursforme_display){ described_class.new(user, status_generator) }
  
  context '#clans' do
    it 'gets the clans the user is a member of' do
      favoursforme_display.clans
      expect(user).to have_received(:clans)
    end
  end
  context '#users' do
    it 'gets all users except the current user' do
      allow(User).to receive(:all).and_return([user,:user2,:user3])
      result = favoursforme_display.users
      expect(result).to eq([:user2,:user3])
    end
  end
  context '#favours' do
    it 'gets the favours benefiting the user' do
      favoursforme_display.favours
      expect(user).to have_received(:favours_for_me)
    end
  end
  context '#status' do
    it 'gets the formepage_favour_status from the status_generator' do
      favoursforme_display.status(:favour)
      expect(generator).to have_received(:formepage_favour_status).with(:favour)
    end
  end
end