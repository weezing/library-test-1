# Create books:

30.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    pages: rand(50..1000),
    year: rand(1450..Time.zone.now.year),
    quantity: 5,
    current_quantity: 5,
    isbn: Faker::Code.isbn
  )
end


Book.all.each do |book|
  book.isbn = Faker::Code.isbn
  book.save
end
