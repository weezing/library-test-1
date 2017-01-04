# Create books:

30.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    pages: rand(50..1000),
    year: rand(1450..Time.zone.now.year),
    quantity: 5,
    current_quantity: 5
  )
end
