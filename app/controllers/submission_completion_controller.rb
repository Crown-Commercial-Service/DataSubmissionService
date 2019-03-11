class SubmissionCompletionController < ApplicationController
  def create
    submission = API::Submission.includes(:task).find(params[:submission_id]).first
    submission.complete

    redirect_to task_submission_path(task_id: submission.task.id, id: submission.id, correction: params[:correction])
  end
end
