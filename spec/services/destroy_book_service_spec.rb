describe DestroyBookService do
  it "destroys book" do
    book = create(:book)
    service = DestroyBookService.new(book)

    expect{ service.call }.to change(Book, :count).by(-1)
  end
end
