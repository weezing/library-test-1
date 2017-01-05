class ReturnBookService
  def initialize(user, book)
    @user = user
    @book = book
  end

  def call
    return false unless book_available_to_return?

    return_book
    recalculate_current_quantity
    add_log
  end

  private

  def book_available_to_return?
    @user.books.include?(@book)
  end

  def return_book
    @borrow = Borrow.find_by(user: @user, book: @book)
    @borrow.destroy
  end

  def recalculate_current_quantity
    @book.current_quantity += 1
    @book.save
  end

  def add_log
    Log.create(book: @book, user: @user, action: "return")
  end
end
