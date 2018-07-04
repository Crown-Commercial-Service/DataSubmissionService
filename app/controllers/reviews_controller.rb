class ReviewsController < ApplicationController
  def new
    @task = API::Task.includes(:framework).find(params[:task_id]).first

    submission = API::Submission.includes(:entries).find(params[:submission_id]).first

    @invoices_count = submission.entries.count { |e| e.source['sheet'].match?(/invoice/i) }
    @orders_count = submission.entries.count { |e| e.source['sheet'].match?(/order/i) }
  end

  def create
    # NO OP
  end
end
