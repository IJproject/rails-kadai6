class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
    @comment = BookComment.new
    @comments = BookComment.all
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    @comment = BookComment.new
    @comments = BookComment.all
  end
  
  private
  
  def comment_params
    params.require(:book_comment).permit(:comment)
  end 
end
