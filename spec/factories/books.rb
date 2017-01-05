FactoryGirl.define do
  factory :book do
    title Faker::Book.title
    author Faker::Book.author
    pages 100
    year 1999
    quantity 1
    current_quantity 1
    isbn "000-000"
  end
end
