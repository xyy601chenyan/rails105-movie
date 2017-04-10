class MoviesController < ApplicationController
before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destroy,:join,:quit,:collect,:cancel]
before_action :find_movie_and_check_permission, only:[:edit,:update,:destroy]


 def collect
   @movie=Movie.find(params[:id])
   if !current_user.has_collected?(@movie)
     current_user.collect!(@movie)
     flash[:notice]="收藏成功"
   else
     flash[:warning]="你已收藏过该项"
   end
   redirect_to movie_path(@movie)
 end

 def cancel
   @movie=Movie.find(params[:id])
   if current_user.has_collected?(@movie)
     current_user.cancel!(@movie)
     flash[:alert]="已取消收藏"
   else
     flash[:warning]="你并未收藏该项,无法取消收藏"
   end
   redirect_to movie_path(@movie)
 end

 def join
   @movie=Movie.find(params[:id])
   if !current_user.is_member_of?(@movie)
     current_user.join!(@movie)
     flash[:notice]="加入讨论版成功!"
   else
     flash[:warning]="你已经是本讨论版成员了!"

   end
   redirect_to movie_path(@movie)
 end

   def quit
     @movie=Movie.find(params[:id])
     if current_user.is_member_of?(@movie)
       current_user.quit!(@movie)
       flash[:alert]="已退出本讨论版"
     else
       flash[:warning]="你不是本讨论版成员,无法退出"
     end
     redirect_to movie_path(@movie)
   end


 def index
   @movies=Movie.all
 end

 def new
   @movie=Movie.new
 end



 def create
   @movie=Movie.new(movie_params)
   @movie.user=current_user
   if @movie.save
     current_user.join!(@movie)
   redirect_to movies_path
 else
   render :new
 end
 end


def show
  @movie=Movie.find(params[:id])
  @reviews=@movie.reviews.recent.paginate(:page=>params[:page],:per_page=>5)
end

def edit


end

def update


  if @movie.update(movie_params)
  redirect_to movies_path, notice: "Update Success"
else
  render :edit
end
end

def destroy


@movie.destroy
flash[:alert]="Movie deleted"
redirect_to movies_path
end

 private

 def movie_params
   params.require(:movie).permit(:title, :description)
 end

 def find_movie_and_check_permission
   @movie=Movie.find(params[:id])
   if current_user!=@movie.user
     redirect_to root_path, alert:"You have no permission."
   end
 end


end
