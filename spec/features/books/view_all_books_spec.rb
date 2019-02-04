require 'rails_helper'

RSpec.feature "Viewing a list of books", :type => :feature do
  background do
    given_i_have_a_list_of_books_i_have_read
  end

  scenario "I am able to see all the books I have recorded as read" do
    when_i_visit_the_books_page
    then_i_should_see_the_list_of_books_i_have_read
    and_i_should_not_see_the_add_new_button
  end

  scenario "as an admin allows me to see the books I have recorded as read" do
    given_i_am_an_admin
    and_i_sign_in
    when_i_visit_the_books_page
    then_i_should_see_the_list_of_books_i_have_read
    and_i_should_see_the_add_new_button
  end

  private
  def given_i_have_a_list_of_books_i_have_read
    @books = FactoryBot.create_list(:book, 5, :with_cover)
  end

  def given_i_am_an_admin
    @user = User.create({email: 'checokelvin@gmail.com', 
                         password: 'testpw123'})
  end

  def and_i_sign_in
    sign_in @user
  end

  def when_i_visit_the_books_page
    visit '/books'
  end

  def then_i_should_see_the_list_of_books_i_have_read
    @books.each do |book|
      expect(page).to have_content("#{book.title}")
    end
  end

  def and_i_should_see_the_add_new_button
    expect(page).to have_css("a[href='/admin/books/new']")
  end

  def and_i_should_not_see_the_add_new_button
    expect(page).to_not have_css("a[href='/admin/books/new']")
  end
end
