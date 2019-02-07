require 'rails_helper'

RSpec.describe 'Skills', type: :request do
  before do
    @user = User.create({email: 'checokelvin@gmail.com', 
      password: 'testpw123'})
  end

  describe 'GET /admin/skills' do
    context 'as a signed_in user' do
      before do
        sign_in @user
        get '/admin/skills'
      end

      it 'returns a success status' do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/skills' }

      it 'redirects to home page' do
        expect(response.status).to eq 302
      end

      it 'providers feedback to non-signed-in user' do
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'GET /admin/skills/new' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/skills/new'
      end

      it 'returns a success status' do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/skills/new' }

      it 'redirects to home page' do
        expect(response.status).to eq 302
      end

      it 'provides feedback to non-signed-in user' do
        expect_not_authorized_flash_message
      end
    end
  end
end