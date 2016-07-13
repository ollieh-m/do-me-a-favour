feature 'User signs up and creates clan' do
  scenario 'then sees it in the list of their clans' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'home')
    expect(page).to display_myclan('3 Greenway Road')
  end
  
  scenario 'which is not in the list of clans for a different user' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'home')
    sign_out
    sign_up(username: 'Testuser2',email: 'testuser2@email.com')
    click_on 'Manage my clans'
    expect(page).not_to display_myclan('3 Greenway Road')
  end
end
feature 'User signs up and creates invalid clan' do
  scenario 'with no name' do
    sign_up
    create_clan(name: '', description: 'home')
    expect(page).to have_content("Name can't be blank")
  end
  
  scenario 'with a name already taken' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'home')
    fill_in('Name', with: '3 Greenway Road')
    fill_in('Description', with: 'home')
    click_on('Create new clan')
    expect(page).to have_content('Name has already been taken')
  end
end