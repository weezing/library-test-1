class CreateBookForm
  include ActiveModel::Model

  attr_accessor(
    :title,
    :author,
    :pages,
    :year,
    :quantity,
    :isbn
  )

  validates :title, :author, :pages, :year, :quantity, :isbn, presence: true
  validates_numericality_of :pages, :year, :quantity
  validates :pages, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }
  validates :year, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1450,
    less_than_or_equal_to: Time.zone.now.year
  }
  validates :quantity, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates_with CreateBookIsbnUniquenessValidator

  def attributes
    {
      title: title,
      author: author,
      pages: pages,
      year: year,
      quantity: quantity,
      current_quantity: quantity,
      isbn: isbn
    }
  end
end
