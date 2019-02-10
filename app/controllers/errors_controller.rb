class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render status: 500 }
    end    
  end
end