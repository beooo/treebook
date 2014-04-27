class ProfilesController < ApplicationController
  def show
    @user = User.where("profile_name = ?",  params[:id]).first
    
    if @user
      
      @statuses = @user.statuses.load
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
    
  end
end
