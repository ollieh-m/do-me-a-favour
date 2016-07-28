feature 'User leaves a clan' do
  scenario 'and it disappears from their list of clans' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'home')
    click_on 'Leave 3 Greenway Road'
    
    expect(page).not_to display_myclan('3 Greenway Road')
    expect(page).to have_button('Join 3 Greenway Road')
  end
end