require 'rails_helper'

RSpec.feature "Update a book", type: :feature do
  background do
    given_i_want_to_apply_changes_to_a_book
  end

  scenario "I am able to successfully change the title of a book" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_title_of_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
  end

  scenario "I am able to successfully change to cover of the book" do
   when_i_click_on_the_book_i_want_to_edit
   and_i_change_the_cover_of_the_book
   and_i_click_the_update_button
   then_i_should_see_the_book_was_successfully_updated
   and_i_should_see_the_updated_cover
  end

  scenario "I am able to successfully change the link to the book" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_link_to_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
  end

  private
  def given_i_want_to_apply_changes_to_a_book
    @book = FactoryBot.create(:book, :with_cover)
  end

  def when_i_click_on_the_book_i_want_to_edit
    visit "/books"
    page.has_content?("#{@book.title}")
    find(:css, "a[href='/books/#{@book.id}/edit").click
  end

  def and_i_change_the_title_of_the_book
    fill_in "Title", :with => "Clean Code"
  end

  def and_i_change_the_link_to_the_book
    fill_in "Link", :with => 'http://example-book-store.com'
  end

  def and_i_change_the_cover_of_the_book
    fill_in "Cover", :with => "http://example.com/new_cover.png"
  end

  def and_i_click_the_update_button
    click_button "Apply Changes"
  end

  def then_i_should_see_the_book_was_successfully_updated
    expect(page).to have_content("Book was successfully updated.")
  end

  def and_i_should_see_the_updated_cover
    expect(page).to have_css("img[src='http://example.com/new_cover.png']")
  end
end
