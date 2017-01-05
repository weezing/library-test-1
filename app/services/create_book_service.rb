class CreateBookService
  def initialize(form)
    @form = form
  end

  def call
    return false unless @form.valid?

    create_book
  end

  private

  def create_book
    Book.create(@form.attributes.merge(
      current_quantity: @form.attributes[:quantity])
    )
  end
end
