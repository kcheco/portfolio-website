class EmailMessageMailer < ApplicationMailer
  def self.send_email_now!
    send_email.deliver_now!
  end

  def self.send_email_later!
    send_email.deliver_later!
  end
  
  def send_email
    @message = params[:message]
    mail to: I18n.t('email_message_mailer.send_email.admin_email'), 
         subject: I18n.t('email_message_mailer.send_email.subject'),
         from: @message.email
  end
end
