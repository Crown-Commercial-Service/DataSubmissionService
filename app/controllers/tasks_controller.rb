class TasksController < ApplicationController
  before_action :ensure_user_signed_in

  def index
    # NO OP
  end

  def complete; end
end
