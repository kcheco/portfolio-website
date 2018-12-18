class BooksController < ApplicationController

  # calls index view and displays a list of all books
  # that have been recorded as read
  def index
    @books = Book.all
  end

  # calls view to be rendered in order for user to add
  # a book that has been read
  def new
    @book_item = Book.new
  end

  # ingest valid book parameters and adds a new book item
  def create
    @book_item = Book.new(book_params)

    respond_to do |format|
      if @book_item.save
        format.html { redirect_to edit_book_path(id: @book_item.id), 
                      notice: "Book was successfully added." }
      else
        format.html { render :new }
      end
    end
  end

  # calls view to be rendered in order for user to edit
  # the details of a book that has been read
  def edit
    @book_item = Book.find(params[:id])
  end

  # ingest valid book parameters and applies changes to existing
  # book item
  def update
    @book_item = Book.find(params[:id])

    respond_to do |format|
      if @book_item.update(book_params)
        format.html { redirect_to edit_book_path(id: @book_item.id), 
                      notice: "Book was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  # removes a book and redirects to books index page
  def destroy
    @book_item = Book.find(params[:id])

    @book_item.destroy

    respond_to do |format|
      format.html { redirect_to books_path, 
                    notice: "Book was successfully deleted."  }
    end
  end

  private
  # specifies valid parameters that may be ingested by the book resource
  def book_params
    params.require(:book)
          .permit(:title,
                  :date_read)
  end
end
