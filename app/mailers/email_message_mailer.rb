class EmailMessageMailer < ApplicationMailer
  def self.send_email! message
    send_email(message).deliver_now!
  end

  def send_email message
    @message = message
    mail to: I18n.t('email_message_mailer.send_email.admin_email'), 
         subject: I18n.t('email_message_mailer.send_email.subject'),
         from: @message.email
  end
end
