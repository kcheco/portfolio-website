require 'rails_helper'

RSpec.describe 'Books', type: :request do
  before do
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  describe 'GET /admin/books' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/books'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/books' }

      it "redirects to books page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        flash_message = "You are not authorized to view admin portal."
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end