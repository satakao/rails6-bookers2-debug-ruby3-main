class FavoritesController < ApplicationController

  def create
    # byebug
    @book = Book.find(params[:book_id])#booksテーブルのbook_idカラムを取得できるのはroutesでbookに対してfavoriteがネストしているから
    @favorite = current_user.favorites.new(book_id: @book.id)
    @favorite.save
    
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    
    #非同期通信を行うためにredirect_toを消すことでcreate.js.erbを探すようになる。gem 'jquery-rails'のインストール必須。
    # redirect_to books_path
  end
  def destroy

    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    # redirect_to books_path
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse

  end
end
