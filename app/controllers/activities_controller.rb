class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json

  def index
    params[:page] ||= 1
    @activities = Activity.for_user(current_user, params)
    respond_with @activities
  end
end
