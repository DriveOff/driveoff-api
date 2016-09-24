# == Schema Information
#
# Table name: businesses
#
#  id      :integer          not null, primary key
#  user_id :integer
#  name    :string           not null
#
# Indexes
#
#  index_businesses_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Business, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
