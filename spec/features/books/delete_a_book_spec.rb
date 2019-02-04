require 'rails_helper'

feature "Deleting a book from list of books read" do
  scenario "as an admin I am able to successfully delete a book" do
    given_i_am_an_admin
    and_i_am_signed_in
    and_i_have_a_book_i_no_longer_want_on_my_list
    when_i_visit_the_books_page
    and_i_click_the_delete_button
    then_i_was_successfully_able_to_delete_book_from_list
    and_i_should_no_longer_see_the_book_i_deleted
  end

  scenario "receives feedback when an non-admin attempts to delete a book" do
    when_i_visit_the_books_page
    then_i_should_see_i_am_not_authorized
  end

  private
  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_am_signed_in
    sign_in @user
  end

  def and_i_have_a_book_i_no_longer_want_on_my_list
    @book = FactoryBot.create(:book, :with_cover)
  end

  def when_i_visit_the_books_page
    visit '/admin/books'
  end

  def and_i_click_the_delete_button
    accept_confirm do
      click_link 'Remove'
    end
  end

  def then_i_was_successfully_able_to_delete_book_from_list
    expect(page).to have_content("Book was successfully deleted.")
  end

  def and_i_should_no_longer_see_the_book_i_deleted
    expect(page).to_not have_content("#{@book.title}")
  end

  def then_i_should_see_i_am_not_authorized
    expect(page).to have_content("You are not authorized")
  end
end
