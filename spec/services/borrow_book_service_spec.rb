describe BorrowBookService do
  it "call: user borrows a book" do
    user = create(:user)
    book = create(:book)
    service = BorrowBookService.new(user, book)

    expect{ service.call }.to change(Borrow, :count).by(1).
      and change(user.borrows, :count).by(1).
      and change{book.current_quantity}.by(-1)
  end

  it "fails when book not available" do
    user = create(:user)
    book = create(:book, current_quantity: 0)
    service = BorrowBookService.new(user, book)

    expect{ service.call }.to change(Borrow, :count).by(0).
      and change(user.borrows, :count).by(0).
      and change{book.current_quantity}.by(0)
  end
end
