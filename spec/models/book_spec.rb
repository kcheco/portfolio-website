require 'rails_helper'

RSpec.describe Book, type: :model do

  it { should validate_presence_of :title }

  it { should validate_presence_of :date_read }

  it { should have_one(:image) }

  it { should validate_presence_of(:image).with_message('Hey, quit being lazy and add the cover of this book!') }

  it { should accept_nested_attributes_for(:image).allow_destroy(true) }
end
