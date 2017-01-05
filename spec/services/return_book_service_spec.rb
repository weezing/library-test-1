describe ReturnBookService do
  it "call: user returns a book" do
    user = create(:user)
    book = create(:book)
    create(:borrow, user: user, book: book)
    service = ReturnBookService.new(user, book)

    expect{ service.call }.to change(Borrow, :count).by(-1).
      and change(user.borrows, :count).by(-1).
      and change{book.current_quantity}.by(1).
      and change(Log, :count).by(1)
  end

  it "fails when user didn't borrow this book" do
    user = create(:user)
    book = create(:book)
    service = ReturnBookService.new(user, book)

    expect{ service.call }.to change(Borrow, :count).by(0).
      and change(user.borrows, :count).by(0).
      and change{book.current_quantity}.by(0).
      and change(Log, :count).by(0)
  end
end
