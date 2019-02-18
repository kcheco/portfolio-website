class EmailMessagesController < ApplicationController
  # calls view to be rendered in order for user to create
  # a new email message
  def new
    @message = EmailMessage.new
  end

  # ingest valid parameters for sending a new email
  def create
    @message = EmailMessage.new(email_message_params)

    respond_to do |format|
      if @message.valid?
        format.html { redirect_to new_email_message_path, 
                      notice: 'Your message was successfully sent.'}
      else
        format.html { render :new }
      end
    end
  end

  private
  # specifies valid parameters that may be ingested when email message
  # is being submitted
  def email_message_params
    params.require(:email_message).permit(:name, 
                                          :company, 
                                          :email, 
                                          :phone, 
                                          :preferred_method, 
                                          :reason, 
                                          :brief_msg)
  end
end