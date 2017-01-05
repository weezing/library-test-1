class LogsController < ApplicationController
  def index
    @logs = Log.all.order("created_at desc").page(params[:page]).per(10)
  end
end
