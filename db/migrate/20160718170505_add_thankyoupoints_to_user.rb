class AddThankyoupointsToUser < ActiveRecord::Migration
  def change
    add_column :users, :thankyoupoints, :integer
  end
end
