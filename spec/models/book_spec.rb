require 'rails_helper'

RSpec.describe Book, type: :model do

  it { should validate_presence_of :title }

  it { should validate_presence_of :date_read }

  it { should validate_presence_of :link }

  it { should have_one(:image) }

  it { should validate_presence_of(:image).with_message('Hey, quit being lazy and add the cover of this book!') }

  it { should accept_nested_attributes_for(:image).allow_destroy(true) }

  it "shows the books I have last read first" do
    first_book = FactoryBot.create(:book, :with_cover, date_read: 1.week.ago)
    last_book = FactoryBot.create(:book, :with_cover, date_read: 1.day.ago)

    expect(Book.last_read.first).to eq(last_book)
    expect(Book.last_read.last).to eq(first_book)
  end
end
