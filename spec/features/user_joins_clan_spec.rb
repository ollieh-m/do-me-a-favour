feature 'User joins a clan' do
  scenario 'and it appears in their list of clans' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'home')
    sign_out
    sign_up(username: 'Testuser2',email: 'testuser2@email.com')
    join_clan
    
    expect(page).to display_myclan('3 Greenway Road')
    expect(page).not_to have_button('Join 3 Greenway Road')
  end
end