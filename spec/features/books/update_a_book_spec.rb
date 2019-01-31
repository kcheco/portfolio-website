require 'rails_helper'

feature "Update a book" do
  background do
    given_i_want_to_apply_changes_to_a_book
    and_i_am_an_admin
    and_i_log_in
  end

  scenario "as an admin allows me to successfully change the title of a book" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_title_of_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
  end

  scenario "as an admin allows me to successfully change to cover of the book" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_cover_of_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
    and_i_should_see_the_updated_cover
  end

  scenario "as an admin allows me to successfully change the link to the book" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_link_to_the_book
    and_i_click_the_update_button
    then_i_should_see_the_book_was_successfully_updated
  end

  scenario "displays error when I change books link to blank" do
    when_i_click_on_the_book_i_want_to_edit
    and_i_change_the_link_to_the_book_to_nothing
    and_i_click_the_update_button
    then_i_should_see_an_error
  end

  private
  def given_i_want_to_apply_changes_to_a_book
    @book = FactoryBot.create(:book, :with_cover)
  end

  def and_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_log_in
    sign_in @user
  end

  def when_i_click_on_the_book_i_want_to_edit
    visit "/admin/books"
    page.has_content?("#{@book.title}")
    find(:css, "a[href='/admin/books/#{@book.id}/edit").click
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

  def and_i_change_the_link_to_the_book_to_nothing
    fill_in "Link", :with => ""
  end

  def then_i_should_see_an_error
    expect(page).to have_content("There was an error.")
  end
end
