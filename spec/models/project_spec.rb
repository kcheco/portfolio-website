require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should validate_presence_of :name }

  it { should validate_presence_of :date_completed }

  it { should validate_presence_of :link }

  it { should allow_values("http://example.com", 
                           "example.com", 
                           "https://example.com", 
                           "http://www.example.com").for(:link) }

  it { should_not allow_values("example", 
                               "http://example", 
                               "example.1234").for(:link) }

  it { should validate_presence_of(:image).with_message("The cover of this project was not added.") }

  it "shows the most recently completed project first" do
    older_project = FactoryBot.create(:project, :with_cover, date_completed: 1.week.ago)
    recent_project = FactoryBot.create(:project, :with_cover, date_completed: 1.day.ago)

    expect(Project.latest.first).to eq(recent_project)
    expect(Project.latest.last).to eq(older_project)
  end
end
