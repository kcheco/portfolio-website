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

end
