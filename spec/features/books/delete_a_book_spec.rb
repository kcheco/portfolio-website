require 'rails_helper'

RSpec.feature "Deleting a book from list of books read", :type => :feature do
  scenario "I am able to successfully delete a book from my list" do
    given_i_have_a_book_i_no_longer_want_on_my_list
    when_i_click_the_delete_button
    then_i_was_successfully_able_to_delete_book_from_list
    and_i_should_no_longer_see_the_book_i_deleted
  end

  private
  def given_i_have_a_book_i_no_longer_want_on_my_list
    @book = FactoryBot.create(:book, :with_cover)
    visit '/books'
  end

  def when_i_click_the_delete_button
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
end
