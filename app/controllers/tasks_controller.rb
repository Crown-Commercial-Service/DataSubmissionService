class TasksController < ApplicationController
  before_action :ensure_user_signed_in

  def index
    @tasks = API::Task.where(user_id: current_user.id).all
  end

  def complete; end
end
