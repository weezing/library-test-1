class UpdateBookForm
  include ActiveModel::Model

  attr_accessor(
    :title,
    :author,
    :pages,
    :year,
    :quantity,
    :current_quantity,
    :isbn
  )

  def initialize(book_attributes, form_attributes = {})
    super book_attributes.merge(form_attributes)
  end

  def attributes
    {
      title: title,
      author: author,
      pages: pages,
      year: year,
      quantity: quantity,
      current_quantity: current_quantity,
      isbn: isbn
    }
  end
end
