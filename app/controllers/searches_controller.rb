class SearchesController < ApplicationController
  def search
    @type = params[:type]
    if @type == "User"
      @text = params[:text]
      @users = User.user_search(params[:match], @text)
    elsif @type == "Book"
      @text = params[:text]
      @books = Book.book_search(params[:match], @text)
    else
      redirect_back(fallback_location: root_path)
    end
      
  end
end
