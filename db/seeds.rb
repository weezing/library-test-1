# Create books:

30.times do
  Book.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    pages: rand(50..1000),
    year: rand(1450..Time.zone.now.year),
    quantity: 5,
    current_quantity: rand(5),
    isbn: Faker::Code.isbn
  )
end

# Create admin:

User.create(
  email: "admin@example.com",
  password: "password",
  is_admin: true,
  confirmed_at: Time.zone.now
)
