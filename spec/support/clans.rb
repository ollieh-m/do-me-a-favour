module Features

  def create_clan(name:, description:)
    click_on 'Manage my clans'
    fill_in('Name', with: name)
    fill_in('Description', with: description)
    click_on('Create new clan')
  end
  
  def display_myclan(name)
    have_css('.myclans li', text: name)
  end

end