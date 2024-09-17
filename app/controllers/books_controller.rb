class BooksController < ApplicationController
  
  before_action :is_matching_login_user, :autheniticate_user, only: [:edit, :update]

  def new
    @books = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully"
      redirect_to book_path(@book.id)
    else
       @books = Book.all.order(id: :asc)
       render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    if @book.save
      flash[:notice] ="You have created book successful"
      redirect_to book_path(@book.id)
    else
       @books = Book.all.order(id: :asc)
       render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all.order(id: :asc)
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :caption, :image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

end
