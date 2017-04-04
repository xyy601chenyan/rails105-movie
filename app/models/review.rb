class Review < ApplicationRecord
  validates :content, presence: {message: "请填写评论内容"}
  belongs_to :user
  belongs_to :movie
end
