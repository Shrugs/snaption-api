# == Schema Information
#
# Table name: captions
#
#  id          :integer          not null, primary key
#  grouping_id :integer
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Caption < ApplicationRecord
  belongs_to :game
  belongs_to :user
end
