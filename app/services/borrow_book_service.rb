class BorrowBookService
  def initialize(user, book)
    @user = user
    @book = book
  end

  def call
    return false unless book_available?

    borrow_book
    recalculate_current_quantity
    add_log
  end

  private

  def book_available?
    Borrow.where(
      user: @user,
      book: @book
    ).blank? && @book.current_quantity > 0
  end

  def borrow_book
    Borrow.create(user: @user, book: @book)
  end

  def recalculate_current_quantity
    @book.current_quantity -= 1
    @book.save
  end

  def add_log
    Log.create(book: @book, user: @user, action: "borrow")
  end
end
