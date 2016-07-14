describe UserFavourRelationship do
  
  it { should belong_to :favour }
  it { should belong_to :user }
  
end