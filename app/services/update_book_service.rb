class UpdateBookService
  def initialize(form)
    @form = form
  end

  def call
    return false unless @form.valid?
  end
end
