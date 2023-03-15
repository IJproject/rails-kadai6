class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.book_search(how_to_match, text)
    if how_to_match == "perfect_match"
      return Book.where("title LIKE?", "#{text}")
    elsif how_to_match == "forward_match"
      return Book.where("title LIKE?", "#{text}%")
    elsif how_to_match == "backward_match"
      return Book.where("title LIKE?", "%#{text}")
    elsif how_to_match == "partial_match"
      return Book.where("title LIKE?", "%#{text}%")
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
end
