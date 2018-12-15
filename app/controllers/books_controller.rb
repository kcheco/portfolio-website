class BooksController < ApplicationController
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
        format.html { redirect_to books_path, notice: "Book was successfully added."}
      else
        format.html { render :new }
      end
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
