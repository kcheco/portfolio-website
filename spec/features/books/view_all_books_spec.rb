require 'rails_helper'

RSpec.feature "Viewing a list of books", :type => :feature do
  scenario "I am able to see all the books I have recorded as read" do
    given_i_have_a_list_of_books_i_have_read
    when_i_visit_the_books_page
    then_i_should_see_the_list_of_books_i_have_read
  end

  private
  def given_i_have_a_list_of_books_i_have_read
    @books = FactoryBot.create_list(:book, 5, :with_cover)
  end

  def when_i_visit_the_books_page
    visit '/books'
  end

  def then_i_should_see_the_list_of_books_i_have_read
    @books.each do |book|
      expect(page).to have_content("#{book.title}")
    end
  end
end
