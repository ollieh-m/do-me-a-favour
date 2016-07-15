module Features

  def display_favour_i_can_bid_on(text:)
    have_css('.favours-i-can-bid-on li', text: text)
  end
  
end