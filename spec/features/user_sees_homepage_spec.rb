feature 'User sees homepage' do
  scenario 'going to root not signed in' do
    visit root_path
    expect(page).to have_content('DO ME A FAVOUR')
  end
end