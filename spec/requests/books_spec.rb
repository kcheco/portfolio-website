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
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'GET /admin/books/new' do
    context 'as a signed-in user' do
      before do
        sign_in @user
        get '/admin/books/new'
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get '/admin/books/new' }

      it "redirects to books page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end

  context 'GET /admin/books/:book_id/edit' do
    before(:each) do
      sign_in @user
      @book = FactoryBot.create(:book, :with_cover)
      sign_out @user
    end

    context 'as a signed-in user' do
      before do
        sign_in @user
        get "/admin/books/#{@book.id}/edit"
      end

      it "has a success http status" do
        expect(response.status).to eq 200
      end
    end

    context 'as a non-signed-in user' do
      before { get "/admin/books/#{@book.id}/edit" }

      it "redirects to books page" do
        expect(response.status).to eq 302
      end

      it "displays feedback to non-signed-in user" do
        expect_not_authorized_flash_message
      end
    end
  end

  describe 'DELETE /admin/books/:id' do
    before(:each) do
      sign_in @user
      @book = FactoryBot.create(:book, :with_cover)
      sign_out @user
    end

    context 'as a signed-in user' do
      before do
        sign_in @user
        delete "/admin/books/#{@book.id}"
      end

      it 'redirects to the books page' do
        expect(response.status).to eq 302
      end

      it 'notifies user book was deleted' do
        expect(flash[:notice]).to eq "Book was successfully deleted."
      end
    end

    context 'as a non-signed-in user' do
      before { delete "/admin/books/#{@book.id}" }

      it 'redirects to books page' do
        expect(response.status).to eq 302
      end

      it 'does not delete the book' do
        expect(Book.first).to eq @book
      end
    end
  end

  private
  def expect_not_authorized_flash_message
    flash_message = "You are not authorized to view admin portal."
    expect(flash[:alert]).to eq flash_message
  end
end