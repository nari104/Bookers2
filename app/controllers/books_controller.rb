class BooksController < ApplicationController

  def new
    @books = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="succesfully"
      redirect_to book_path(@book.id)
    else
       flash.now[:notice] = "投稿に失敗しました"
       @books = Book.all.order(id: :asc)
       render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
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
      flash[:notice] = "updateに失敗しました"
      @books = Book.all.order(id: :asc)
      render :index
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :caption, :image)
  end

end
