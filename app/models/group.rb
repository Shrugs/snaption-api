class Group < ApplicationRecord

  has_many :users, through: :groupings
  has_many :groupings, dependent: :destroy

end
