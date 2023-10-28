class Book < ApplicationRecord
  belongs_to:user
  has_many:favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  def book_commented_by?(user)
    book_comments.exists?(user_id: user.id)
  end
end
