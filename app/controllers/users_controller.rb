class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :set_user, only: [:followings, :followers]

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    @books = @user.books
    @book = Book.new
    @is_room = false
    @room_id = nil
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id
            @is_room = true
            @room = current.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
  end


  def index
    @user = current_user
    @relationship = @user.relationships
    @users = User.all
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else

      render :edit
    end
  end
  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
