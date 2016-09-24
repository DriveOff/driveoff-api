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

require 'rails_helper'

RSpec.describe Reward, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
