class UpdateBookIsbnUniquenessValidator < ActiveModel::Validator
  def validate(record)
    if Book.where.not(id: record.id).where(isbn: record.isbn).present?
      record.errors[:isbn] << _("has already been taken")
    end
  end
end
