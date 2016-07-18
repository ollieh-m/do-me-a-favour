class AddCompletedToFavour < ActiveRecord::Migration
  def change
    add_column :favours, :completed, :string
    add_index :favours, :completed
  end
end
