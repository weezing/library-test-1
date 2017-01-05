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

    @book.destroy
  end

  def book_borrowed?
    Borrow.where(book: @book).any?
  end
end
