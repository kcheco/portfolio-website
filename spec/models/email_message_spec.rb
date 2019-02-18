require 'rails_helper'

RSpec.describe 'EmailMessage', type: :model do

  subject { EmailMessage.new }

  it { should respond_to :name } 
  it { should respond_to :company }
  it { should respond_to :email }
  it { should respond_to :phone }
  it { should respond_to :preferred_method }
  it { should respond_to :reason }
  it { should respond_to :brief_msg }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :preferred_method }
  it { should validate_presence_of :reason }
  it { should validate_presence_of :brief_msg }

  preferred_method_array = %w( email phone )
  it { should validate_inclusion_of(:preferred_method).in_array(preferred_method_array) }

  reason_array = %w( general_question job_offer_fulltime job_offer_consulting job_offer_contract provide_feedback )
  it { should validate_inclusion_of(:reason).in_array(reason_array) }

  it { should validate_length_of(:brief_msg).is_at_least(1).is_at_most(255) }

  context 'with valid attribute values' do
    before do
      attr_values = {
        name: 'Ip Man',
        email: 'ipman@testing.com',
        phone: '5555555555',
        preferred_method: 'email',
        reason: 'general_question',
        brief_msg: 'Testing an email message'
      }
      @msg = EmailMessage.new attr_values
    end

    it 'is valid' do
      expect(@msg).to be_valid
    end
  end

  context 'with invalid attribute values' do
    before do
      attr_values = {
        name: '',
        email: '',
        phone: '',
        preferred_method: '',
        reason: '',
        brief_msg: ''
      }
      @msg = EmailMessage.new attr_values
    end

    it 'is not valid' do
      expect(@msg).to_not be_valid
    end
  end
end
