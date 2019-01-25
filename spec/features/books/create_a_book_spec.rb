require 'rails_helper'

feature "Creating a book" do
  scenario "I am able to successfully add a book" do
    when_i_want_to_create_a_book
    and_i_set_the_title
    and_i_set_the_date_i_read_the_book
    and_i_set_the_link_about_the_book
    and_i_set_the_cover_of_the_book
    and_i_click_the_create_button
    then_i_should_see_the_book_was_added_successfully
    and_i_should_see_the_cover_of_the_book
  end

  scenario "always needs a cover" do
    when_i_want_to_create_a_book
    and_i_set_the_title
    and_i_set_the_date_i_read_the_book
    and_i_click_the_create_button
    then_i_should_receive_an_error_for_not_setting_a_cover
  end

  private
  def when_i_want_to_create_a_book
    visit "/books"
    click_link "Add New Book"
  end

  def and_i_set_the_title
    fill_in "Title", :with => "The Clean Coder"
  end

  def and_i_set_the_date_i_read_the_book
    fill_in "Date Read", :with => "2018/12/13"
    # closes datepicker
    find('.ui-datepicker-close').click
  end

  def and_i_set_the_link_about_the_book
    fill_in "Link", :with => "#{Faker::Internet.url}"
  end

  def and_i_set_the_cover_of_the_book
    fill_in "Cover", :with => "https://images-na.ssl-images-amazon.com/images/I/5154eSTKUxL._SX382_BO1,204,203,200_.jpg"
  end

  def and_i_click_the_create_button
    click_button "Add Book"
  end

  def then_i_should_see_the_book_was_added_successfully
    expect(page).to have_content("Book was successfully added.")
  end

  def then_i_should_receive_an_error_for_not_setting_a_cover
    expect(page).to have_content("Hey, quit being lazy and add the cover of this book!")
  end

  def and_i_should_see_the_cover_of_the_book
    expect(page).to have_css("img[src='https://images-na.ssl-images-amazon.com/images/I/5154eSTKUxL._SX382_BO1,204,203,200_.jpg']")
  end
end
