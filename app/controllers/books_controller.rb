class BooksController < ApplicationController
  def index
    @books = BookQuery.new(books_params).results
  end

  private

  def books_params
    params.permit(:per, :page)
  end
end
