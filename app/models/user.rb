class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }, uniqueness: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def self.user_search(how_to_match, text)
    if how_to_match == "perfect_match"
      return User.where("name LIKE?", "#{text}")
    elsif how_to_match == "forward_match"
      return User.where("name LIKE?", "#{text}%")
    elsif how_to_match == "backward_match"
      return User.where("name LIKE?", "%#{text}")
    elsif how_to_match == "partial_match"
      return User.where("name LIKE?", "%#{text}%")
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
