feature 'User confirms a favour has been carried out' do
  before do
    sign_up(username: 'Testuser2', email: 'testuser2@email.com')
    sign_out
    
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    create_favour(users_benefiting: ['Testuser2'])
    sign_out
    
    sign_up(username: 'Testuser3', email:'testuser3@email.com')
    join_clan
    make_bid(user: 'Testuser3', points: 20)
    sign_out
    
    sign_in
    accept_bid(bid_number: 1)
    confirm_favour_has_been_done(user: 'Testuser3', bid_number: 1)
    sign_out
  end
  
  scenario "and status appears as 'Nice one - you did this favour' if the user's bid had been accepted" do
    sign_in(email: 'testuser3@email.com', password: '123456')
    click_on 'Favours for others'
    expect(page).to display_favour_i_bidded_on_status('Nice one - you did this favour')
  end
  
  scenario "and status appears as 'This favour has been carried out' if the favour benefited you" do
    sign_in
    click_on 'Favours for me'
    expect(page).to display_favour_for_me_status('This favour has been carried out')
  end
  
  context "and Thank you points are exchanged" do
    scenario '- the user who made the accepted bid gains the specified thank you points' do
      sign_in(email: 'testuser3@email.com', password: '123456')
      expect(page).to have_content '120 Thank You Points'
    end
    
    scenario '- the users who benefited from the favour each lose their share of the specified thank you points' do
      sign_in
      expect(page).to have_content '90 Thank You Points'
      sign_out
      sign_in(email: 'testuser2@email.com', password: '123456')
      expect(page).to have_content '90 Thank You Points'
    end
  end
  
end