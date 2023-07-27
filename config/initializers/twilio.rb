# config/initializers/twilio.rb

require 'twilio-ruby'

Twilio.configure do |config|
  config.account_sid = ''     # Replace with your Twilio Account SID
  config.auth_token = ''       # Replace with your Twilio Auth Token
end
