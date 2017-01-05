describe CreateBookService do
  it "call: create book" do
    form = double(
      valid?: true,
      attributes: {
        quantity: 3
      }
    )

    service = CreateBookService.new(form)
    expect { service.call }.to change(Book, :count).by(1)
    expect(Book.last.current_quantity).to eq(3)
  end

  it "invalid form" do
    form = double(
      valid?: false
    )

    service = CreateBookService.new(form)
    expect(service.call).to eq(false)
    expect { service.call }.to change(Book, :count).by(0)
  end
end
