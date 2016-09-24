# == Schema Information
#
# Table name: rewards
#
#  id          :integer          not null, primary key
#  business_id :integer
#  title       :string           not null
#  description :text
#  cost        :integer          not null
#
# Indexes
#
#  index_rewards_on_business_id  (business_id)
#

class Reward < ActiveRecord::Base
  belongs_to :business
  
  validates :title, presence: true
  validates :cost, presence: true
end
