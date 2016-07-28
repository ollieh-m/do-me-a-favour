module Features

  def create_clan(name:, description:)
    click_on 'Manage my clans'
    fill_in('Name', with: name)
    fill_in('Then describe the clan...', with: description)
    click_on('Create new clan')
  end
  
  def join_clan(name: '3 Greenway Road')
    click_on 'Manage my clans'
    click_on "Join #{name}"
  end
  
  def display_myclan(name)
    have_css('.myclans li', text: name)
  end

end