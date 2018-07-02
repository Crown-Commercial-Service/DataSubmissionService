class TasksController < ApplicationController
  before_action :ensure_user_signed_in

  def index
    @tasks = API::Task.all
  end

  def complete; end
end
