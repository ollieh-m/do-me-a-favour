module Features
  
  def sign_up(username: 'Testuser', email: 'testuser@email.com', password: '123456')
    visit root_path
    click_on 'Sign up'
    fill_in('Username', with: username)
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    within(:css, '.new_user') do
      click_on 'Sign up'
    end
  end
  
  def sign_out
    click_on 'Sign out'
  end
  
  def sign_in(email: 'testuser@email.com', password: '123456')
    click_on 'Sign in'
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    within(:css, '.sign_in') do
      click_on 'Sign in'
    end
  end
  
end