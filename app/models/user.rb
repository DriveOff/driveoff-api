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
#
# Indexes
#
#  index_users_on_email                                (email) UNIQUE
#  index_users_on_last_logout_at_and_last_activity_at  (last_logout_at,last_activity_at)
#  index_users_on_remember_me_token                    (remember_me_token)
#  index_users_on_reset_password_token                 (reset_password_token)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  validates :email, uniqueness: true, presence: true
  
  validates :password, length: { minimum: 8 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  
  validates :name, presence: true
  
  validates :role, presence: true
  enum role: { user: 1, business_admin: 2, admin: 3 }
  
  pg_search_scope :search_by_email,
                  against: :email,
                  :using => {
                    :tsearch => {:prefix => true}
                  }
  
  # Users can friend each other
  has_and_belongs_to_many :users
end
