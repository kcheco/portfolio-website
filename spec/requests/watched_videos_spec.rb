require 'rails_helper'

RSpec.describe 'WatchedVideos', type: :request do
  before do
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  describe 'GET /admin/watched_videos' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/watched_videos'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/watched_videos' }

      it "redirects to watched_videos page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
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

  describe 'DELETE /admin/watched_videos/:id' do
    before(:each) do
      sign_in @user
      @watched_video = FactoryBot.create(:watched_video, :with_cover)
      sign_out @user
    end

    context 'as a signed-in user' do
      before do
        sign_in @user
        delete "/admin/watched_videos/#{@watched_video.id}"
      end

      it 'redirects to the watched_videos page' do
        expect(response.status).to eq 302
      end

      it 'notifies user watched_video was deleted' do
        expect(flash[:notice]).to eq "Video was successfully deleted."
      end
    end

    context 'as a non-signed-in user' do
      before { delete "/admin/watched_videos/#{@watched_video.id}" }

      it 'redirects to watched_videos page' do
        expect(response.status).to eq 302
      end

      it 'does not delete the watched_video' do
        expect(WatchedVideo.first).to eq @watched_video
      end
    end
  end
end