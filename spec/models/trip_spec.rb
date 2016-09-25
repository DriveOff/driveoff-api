# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  distance   :decimal(6, 1)    default(0.0), not null
#  time       :integer          default(0), not null
#  points     :integer          default(0), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_trips_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Trip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
