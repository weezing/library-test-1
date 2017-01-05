class UpdateBookService
  def initialize(form, book)
    @form = form
    @book = book
  end

  def call
    return false unless @form.valid?

    update_book
    recalculate_quantity
  end

  private

  def update_book
    @book.update_attributes(@form.attributes)
  end

  def recalculate_quantity
    @book.update_attributes(
      quantity: current_quantity
    )
  end

  def current_quantity
    @form.attributes[:current_quantity].to_i + Borrow.where(book: @book).count
  end
end
