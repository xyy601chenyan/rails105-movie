class Movie < ApplicationRecord
  validates :title , presence: {message:"请填写电影名"}

  belongs_to :user
  has_many :reviews
end
