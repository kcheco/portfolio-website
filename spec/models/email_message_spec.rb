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

  it { should allow_values('test@domain.com', 'hello@domain.dev').for(:email) }
  
  it { should_not allow_value("test@domain", " ").for(:email) }
  
  it { should validate_numericality_of(:phone).only_integer }

  it { should validate_length_of(:phone).is_at_least(10).with_message("must have at least 10 digits") }
  it { should validate_length_of(:phone).is_at_most(11).with_message("can't be more than 11 digits") }

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

  context 'with invalid email format' do
    before do
      attr_values = {
        name: 'Ip Man',
        email: 'test@email',
        phone: '5555555555',
        preferred_method: 'email',
        reason: 'general_question',
        brief_msg: 'This is a test.'
      }
      @msg = EmailMessage.new attr_values
    end

    it 'is not valid' do
      expect(@msg).to_not be_valid
    end
  end

  context 'with invalid email format' do
    before do
      attr_values = {
        name: 'Ip Man',
        email: 'test@email.com',
        phone: '555555',
        preferred_method: 'email',
        reason: 'general_question',
        brief_msg: 'This is a test.'
      }
      @msg = EmailMessage.new attr_values
    end

    it 'is not valid' do
      expect(@msg).to_not be_valid
    end
  end
end
