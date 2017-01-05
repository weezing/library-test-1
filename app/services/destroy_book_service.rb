class DestroyBookService
  def initialize(book)
    @book = book
  end

  def call
    destroy_book
  end

  private

  def destroy_book
    @book.destroy
  end
end
