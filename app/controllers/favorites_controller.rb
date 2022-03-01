class FavoritesController < ApplicationController
  # before_action :set_book
  before_action :authenticate_user!


  def create
    @book = Book.find(params[:book_id])
    # @favorite = @book.favorites.new(user_id: current_user.id)
    @favorite = current_user.favorites.new(book_id: @book.id)
    @favorite.save
    # render 'replace_favorite-btn'
    # redirect_back fallback_location: @book
  end

  def destroy
    @book = Book.find(params[:book_id])
    # @favorite = @book.favorites.find_by(user_id: current_user.id)
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    # render 'replace_favorite-btn'
    # redirect_back fallback_location: @book
  end

# private
#   def set_book
#     @book = Book.find(params[:book_id])
#   end


end
