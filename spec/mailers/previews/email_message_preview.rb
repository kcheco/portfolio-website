# Preview all emails at http://localhost:3000/rails/mailers/email_message
class EmailMessagePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/email_message/send_email
  def send_email
    message = EmailMessage.new({
      name: 'John Doe',
      company: 'Testing Co',
      email: 'johndoe@example.com',
      phone: '5555555555',
      preferred_method: 'phone',
      reason: 'general_question',
      brief_msg: 'What stack did you use?'
    })

    EmailMessageMailer.with(message: message).send_email
  end

end
