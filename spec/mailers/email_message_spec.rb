require "rails_helper"

RSpec.describe EmailMessageMailer, type: :mailer do
  describe ".send_email" do
    before do
      @message = EmailMessage.new ({
        name: 'John Doe',
        email: 'johndoe@example.com',
        phone: '5555555555',
        preferred_method: 'phone',
        reason: 'general_question',
        brief_msg: 'What stack did you use?'
      })
      @email = EmailMessageMailer.with(message: @message).send_email
    end

    it "delivers the email" do
      @email.deliver_now
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "renders the subject in the headers" do
      expect(@email.subject).to eq("Message from kelvin-checo.dev")
    end

    it "renders the recipient's email in the headers" do
      expect(@email.to).to eq(["checokelvin@gmail.com"])
    end

    it "renders the sender's email in the headers" do 
      expect(@email.from).to eq([@message.email])
    end

    it "renders the body" do
      expect(@email.body.encoded).to match(@message.brief_msg)
    end
  end
end
