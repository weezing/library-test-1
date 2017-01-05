class LogsController < ApplicationController
  def index
    @logs = Log.all
    @logs = @logs.where(user_id: current_user.id) unless current_user.is_admin?
    @logs = @logs.order("created_at desc").page(params[:page]).per(10)
  end
end
