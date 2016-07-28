module Features

  def make_bid(user: 'Testuser', points:)
    click_on "#{user}'s dashboard"
    click_on 'Favours for others'
    fill_in('Number of thank you points', with: points.to_s)
    click_on 'Bid'
  end

  def accept_bid(user: 'Testuser', bid_number:)
    click_on "#{user}'s dashboard"
    click_on 'Favours for me'
    within(:css, ".favours-benefiting-me li#bid_#{bid_number.to_s}") do
      click_on 'Accept bid'
    end
  end

end