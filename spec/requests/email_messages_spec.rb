require 'rails_helper'

RSpec.describe 'EmailMessages', type: :request do
  let (:form_attributes) {
    {
      name: 'Hamilton Quark',
      email: 'test@example.com',
      phone: '2125555555',
      preffered_method: 'phone',
      reason: 'general_question',
      brief_msg: 'Tesing to reach the admin of this app.'
    }
  }

  describe 'POST /contact_me' do
    context 'with valid parameters' do
      before do
        post '/contact_me', params: { email_message: form_attributes }
      end

      it 'returns success http status' do
        expect(response.status).to eq 200
      end
    end

    context 'with invalid parametes' do
      before do
        form_attributes[:email] = ''
        form_attributes[:phone] = ''

        post '/contact_me', params: { email_message: form_attributes }
      end

      it 'returns errors' do
        expect(response.body).to include("There was an error")
      end

      it 'returns email can\'t be blank' do
        expect(response.body).to include("Email can't be blank")
      end

      it 'returns phone can\'t be blank' do
        expect(response.body).to include("Phone can't be blank")
      end
    end
  end

  describe 'GET /contact' do
    before { get '/contact' }

    it 'returns unauthorizaed http status' do
      expect(response.status).to eq 404
    end
  end
end