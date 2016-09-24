# == Schema Information
#
# Table name: rewards
#
#  id          :integer          not null, primary key
#  business_id :integer
#  title       :string           not null
#  description :text
#  cost        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_rewards_on_business_id  (business_id)
#

class Reward < ActiveRecord::Base
  belongs_to :business
  has_many :redemptions
  
  validates :title, presence: true
  validates :cost, presence: true
end
