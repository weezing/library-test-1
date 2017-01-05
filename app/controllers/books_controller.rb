class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def index
    @books = BookQuery.new(books_params).results
  end

  def new
    @form = CreateBookForm.new
  end

  def create
    @form = CreateBookForm.new(book_form_params)
    service = CreateBookService.new(@form)

    if service.call
      redirect_to books_path, notice: _("Book added successfully")
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def books_params
    params.permit(:per, :page)
  end

  def book_form_params
    params.require(:book_form).permit(
      :title,
      :author,
      :year,
      :pages,
      :isbn,
      :quantity
    )
  end
end
