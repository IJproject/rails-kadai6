class SearchesController < ApplicationController
  def search
    type = params[:type]
    if type == "User"
      @users = User.looks(params[:match], params[:text])
    elsif type == "Book"
      @books = Book.looks(params[:match], params[:text])
    else
      redirect_back(fallback_location: root_path)
    end
      
  end
  
  private
  
  # titleじゃダメじゃないか？
  # 相当な改良が必要な気がする(例を)
  def looks(how_to_match, text)
    if how_to_match == "perfect_match"
      return where("title LIKE?", "#{text}")
    elsif how_to_match == "forward_match"
      return where("title LIKE?", "#{text}%")
    elsif how_to_match == "backward_match"
      return where("title LIKE?", "%#{text}")
    elsif how_to_match == "partial_match"
      return where("title LIKE?", "%#{text}%")
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  
end
