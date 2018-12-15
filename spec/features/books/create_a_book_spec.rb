require 'rails_helper'

RSpec.feature "Creating a book", :type => :feature do
  scenario "I am able to successfully add a book" do
    given_i_want_to_create_a_book
    when_i_set_the_title
    and_i_set_the_date_i_read_the_book
    and_i_click_the_create_button
    then_i_should_see_the_book_was_added_successfully
  end

  def given_i_want_to_create_a_book
    visit "/books/new"
  end

  def when_i_set_the_title
    fill_in "Title", :with => "The Clean Coder"
  end

  def and_i_set_the_date_i_read_the_book
    fill_in "Date Read", :with => "2018/12/13"
  end

  def and_i_click_the_create_button
    click_button "Add Book"
  end

  def then_i_should_see_the_book_was_added_successfully
    expect(page).to have_content("Book was successfully added.")
  end
end
