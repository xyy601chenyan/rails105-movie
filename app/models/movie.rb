class Movie < ApplicationRecord
  validates :title , presence: {message:"请填写电影名"}

  belongs_to :user
  has_many :reviews

  has_many :movie_relationships
  has_many :members, through: :movie_relationships, source: :user

  def has_member?(user)
    members.include?(user)
  end

  def in!(user)
    members << user
  end

  def out!(user)
    members.delete(user)
  end

end
