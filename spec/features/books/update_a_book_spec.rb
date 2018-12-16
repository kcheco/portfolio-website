require 'rails_helper'

RSpec.feature "Update a book", type: :feature do
  scenario "I am able to successfully change the title of a book" do
    given_i_want_to_edit_the_title_of_a_book
    when_i_change_the_title_of_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
  end

  def given_i_want_to_edit_the_title_of_a_book
    book = FactoryBot.create(:book)
    visit "/books/#{book.id}/edit"
  end

  def when_i_change_the_title_of_the_book
    fill_in "Title", :with => "Clean Code"
  end

  def and_i_click_the_update_button
    click_button "Update Book"
  end

  def then_i_should_see_the_book_was_successfully_updated
    expect(page).to have_content("Book was successfully updated.")
  end
end
