describe DestroyBookService do
  it "destroys book" do
    book = create(:book)
    service = DestroyBookService.new(book)

    expect{ service.call }.to change(Book, :count).by(-1)
  end

  it "does not destroy book if borrowed" do
    book = create(:book)
    create(:borrow, book: book)
    service = DestroyBookService.new(book)

    expect{ service.call }.to change(Book, :count).by(0)
  end
end
