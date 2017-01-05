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

  validates :title, :author, :pages, :year, :current_quantity, :isbn, presence: true
  validates_numericality_of :pages, :year, :current_quantity
  validates :pages, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
  validates :year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1450,
    less_than_or_equal_to: Time.zone.now.year
  }
  validates :current_quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates_with IsbnUniquenessValidator

  def initialize(book_attributes, form_attributes = {})
    super book_attributes.merge(form_attributes)
  end

  def attributes
    {
      title: title,
      author: author,
      pages: pages,
      year: year,
      quantity: current_quantity,
      current_quantity: current_quantity,
      isbn: isbn
    }
  end
end
