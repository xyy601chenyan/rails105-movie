class Movie < ApplicationRecord
  validates :title , presence: {message:"请填写电影名"}
  
end
