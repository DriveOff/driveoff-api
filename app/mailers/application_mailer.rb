class ApplicationMailer < ActionMailer::Base
  address = Mail::Address.new "no-reply@driveoff.herokuapp.com"
  address.display_name = "Drive Off"
  
  default from: address
  
  layout 'mailer'
end
