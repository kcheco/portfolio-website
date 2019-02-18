class EmailMessagesController < ApplicationController
  def new
    @contact = EmailMessage.new
  end
end