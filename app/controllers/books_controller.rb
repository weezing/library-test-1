class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show]

  def index
    @books = BookQuery.new(books_params).results
  end

  def new
    @form = CreateBookForm.new
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def books_params
    params.permit(:per, :page)
  end
end
