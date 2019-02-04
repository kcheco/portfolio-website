require 'rails_helper'

RSpec.describe 'WatchedVideos', type: :request do
  before do
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  describe 'GET /admin/watched_videos/new' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/watched_videos/new'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/watched_videos/new' }

      it "redirects to watched_videos page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end
end