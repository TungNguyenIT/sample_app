class ApplicationMailer < ActionMailer::Base
  default from: ENV["GMAIL_DEFAULT"]
  layout "mailer"
end
