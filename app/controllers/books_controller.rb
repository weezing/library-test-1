class BooksController < ApplicationController
  before_action :authenticate_user!, only: [
    :new,
    :create,
    :show,
    :edit,
    :update,
    :destroy,
    :borrow,
    :return
  ]
  before_action :load_book, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :borrow,
    :return
  ]
  before_action :check_permission, only: [
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

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
  end

  def edit
    @form = UpdateBookForm.new(book_attributes)
  end

  def update
    @form = UpdateBookForm.new(
      book_attributes.merge(id: @book.id),
      book_form_params
    )
    service = UpdateBookService.new(@form, @book)

    if service.call
      redirect_to books_path, notice: _("Book updated successfully")
    else
      render :edit
    end
  end

  def destroy
    service = DestroyBookService.new(@book)

    if service.call
      redirect_to books_path, notice: _("Book deleted successfully")
    else
      redirect_to books_path, alert: _("Someone didn't return this book!")
    end
  end

  def borrow
    service = BorrowBookService.new(current_user, @book)

    if service.call
      redirect_to my_books_books_path, notice: _("Book borrowed successfully")
    else
      redirect_to my_books_books_path, alert: _("This book can't be borrowed")
    end
  end

  def return
    service = ReturnBookService.new(current_user, @book)

    if service.call
      redirect_to my_books_books_path, notice: _("Book returned successfully")
    else
      redirect_to my_books_books_path, alert: _("Something went wrong")
    end
  end

  def my_books
    @books = BookQuery.new(
      books_params.merge(user_id: current_user.id)
    ).results
  end

  private

  def load_book
    @book = Book.find(params[:id])
  end

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
      :quantity,
      :current_quantity
    )
  end

  def book_attributes
    @book.slice(
      :title,
      :author,
      :year,
      :pages,
      :isbn,
      :quantity,
      :current_quantity
    )
  end

  def check_permission
    return if current_user.is_admin?

    redirect_to root_path, alert: _("You don't have permission do enter here")
  end
end
