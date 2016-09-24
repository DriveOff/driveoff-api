# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string           not null
#  salt                            :string           not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string
#  name                            :string           not null
#  role                            :integer          default(1), not null
#  avatar                          :string
#  city                            :string
#  state                           :string
#  zip_code                        :integer
#  birthday                        :date             default(Tue, 01 Jan 1980), not null
#  gender                          :integer          default(1), not null
#  custom_gender                   :string
#  pronouns                        :integer
#
# Indexes
#
#  index_users_on_email                                (email) UNIQUE
#  index_users_on_last_logout_at_and_last_activity_at  (last_logout_at,last_activity_at)
#  index_users_on_remember_me_token                    (remember_me_token)
#  index_users_on_reset_password_token                 (reset_password_token)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
