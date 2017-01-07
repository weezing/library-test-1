class DestroyBookService
  def initialize(book)
    @book = book
  end

  def call
    destroy_book
  end

  private

  def destroy_book
    return false if book_borrowed?

    destroy_logs
    @book.destroy
  end

  def book_borrowed?
    Borrow.where(book: @book).any?
  end

  def destroy_logs
    Log.where(book: @book).destroy_all
  end
end
