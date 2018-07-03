class ReviewsController < ApplicationController
  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first

    submission = API::Submission.includes(:entries).find(params[:submission_id]).first

    @invoices_count = submission.entries.select { |e| e.source['type'] == 'InvoicesReceived' }.count
    @orders_count = submission.entries.select { |e| e.source['type'] == 'OrdersRaised' }.count
  end

  def create
    # NO OP
  end
end
