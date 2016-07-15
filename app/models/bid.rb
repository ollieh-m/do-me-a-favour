class Bid < ActiveRecord::Base
  belongs_to :favour
  belongs_to :user
end
