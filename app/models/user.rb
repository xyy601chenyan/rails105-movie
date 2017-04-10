class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :movies
  has_many :reviews

  has_many :movie_relationships
  has_many :participated_movies, :through=> :movie_relationships, :source=> :movie

#判断当前user是否为movie群组成员
  def is_member_of?(movie)
    participated_movies.include?(movie)
  end

  def join!(movie)
    participated_movies << movie
  end

  def quit!(movie)
    participated_movies.delete(movie)
  end


  def has_collected?(movie)
    participated_movies.include?(movie)
  end

  def collect!(movie)
    participated_movies << movie
  end

  def cancel!(movie)
    participated_movies.delete(movie)
  end


end
