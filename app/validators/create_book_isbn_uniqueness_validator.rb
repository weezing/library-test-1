class CreateBookIsbnUniquenessValidator < ActiveModel::Validator
  def validate(record)
    if Book.where(isbn: record.isbn).present?
      record.errors[:isbn] << _("has already been taken")
    end
  end
end
