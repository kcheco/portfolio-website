require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  before do
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  describe 'GET /admin/projects' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/projects'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/projects' }

      it "redirects to projects page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'GET /admin/projects/new' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/projects/new'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/projects/new' }

      it "redirects to projects page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'GET /admin/projects/:id/edit' do
    before(:each) do
      sign_in @user
      @project = FactoryBot.create(:project, :with_cover)
      sign_out @user
    end

    context 'as a signed-in user' do
      before do
        sign_in @user
        get "/admin/projects/#{@project.id}/edit"
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get "/admin/projects/#{@project.id}/edit" }

      it "redirects to projects page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'DELETE /admin/projects/:id' do
    before(:each) do
      sign_in @user
      @project = FactoryBot.create(:project, :with_cover)
      sign_out @user
    end

    context 'as a signed-in user' do
      before do
        sign_in @user
        delete "/admin/projects/#{@project.id}"
      end

      it 'redirects to the projects page' do
        expect(response.status).to eq 302
      end

      it 'notifies user project was deleted' do
        expect(flash[:notice]).to eq "Project was successfully deleted."
      end
    end

    context 'as a non-signed-in user' do
      before { delete "/admin/projects/#{@project.id}" }

      it 'redirects to projects page' do
        expect(response.status).to eq 302
      end

      it 'does not delete the project' do
        expect(Project.first).to eq @project
      end
    end
  end
end