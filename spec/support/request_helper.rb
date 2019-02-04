module RequestSpecHelper
  module AuthorizationHelpers
    def expect_not_authorized_flash_message
      flash_message = "You are not authorized to view admin portal."
      expect(flash[:alert]).to eq flash_message
    end
  end
end