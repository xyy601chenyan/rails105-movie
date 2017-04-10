class Account::CollectionsController < ApplicationController
  before_action :authenticate_user!
  def index
   @movies=current_user.participated_movies.recent
 end

end
