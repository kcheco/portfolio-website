module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :catch_404
  end

  private
  def catch_404
    render "errors/not_found", status: 404
  end
end