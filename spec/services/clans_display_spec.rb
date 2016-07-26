describe ClansDisplay do
  
  let(:user){ double(:user, clans: [:clan1, :clan2, :clan3]) }
  let(:clans_display){ described_class.new(user) }
  
  context '#new_clan' do
    it 'initializes a clan' do
      expect(Clan).to receive(:new)
      clans_display.new_clan
    end
  end
  context '#my_clans' do
    it "returns the user's clans" do
      expect(clans_display.my_clans).to eq [:clan1, :clan2, :clan3]
    end
  end
  context '#other_clans' do
    it 'returns all clans minus my_clans' do
      allow(Clan).to receive(:all).and_return([:clan1, :clan2, :clan3, :clan4])
      expect(clans_display.other_clans).to eq [:clan4]
    end
  end
    
end