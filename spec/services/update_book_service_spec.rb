describe UpdateBookService do
  it "call: update book" do
    book = create(:book, author: "Jan Kowalski")
    form = double(
      valid?: true,
      attributes: {
        author: "Piotr Nowak"
      }
    )

    service = UpdateBookService.new(form, book)
    expect(service.call).to eq(true)
    expect(book.reload.author).to eq("Piotr Nowak")
  end

  it "recalculates books quantity" do
    book = create(:book, quantity: 5, current_quantity: 5)
    form = double(
      valid?: true,
      attributes: {
        current_quantity: 2
      }
    )

    service = UpdateBookService.new(form, book)
    expect(service.call).to eq(true)
    expect(book.reload.quantity).to eq(2)
  end

  it "returns false" do
    book = create(:book, quantity: 5, current_quantity: 5)
    form = double(
      valid?: false
    )

    service = UpdateBookService.new(form, book)
    expect(service.call).to eq(false)
  end
end
