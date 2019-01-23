require 'rails_helper'

RSpec.describe WatchedVideo, type: :model do

  it { should validate_presence_of :title }

  it { should validate_presence_of :date_viewed }

  it { should validate_presence_of :link }

  it { should allow_value('https://youtu.be/LMnrH1CN4oc').for(:link) }

  it { should_not allow_values('example.123').for(:link) }

  it { should validate_presence_of(:image).with_message("Hey, the cover of this video you watched isn't going to add itself!") }

  it { should have_one(:image) }

  it { should accept_nested_attributes_for(:image).allow_destroy(true) }

  it "shows the last viewed videos first" do
    old_video = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.month.ago)
    recent_video = FactoryBot.create(:watched_video, :with_cover, date_viewed: 1.day.ago)

    expect(WatchedVideo.last_viewed.first).to eq(recent_video)
    expect(WatchedVideo.last_viewed.last).to eq(old_video)
  end

end
