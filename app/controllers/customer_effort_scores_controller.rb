# class CustomerEffortScoresController < ApplicationController

# #   def new
# #     pp "params-------------------"
# #     pp params
# #     pp "CustomerEffortScore:::new::::::::::::::::"
# #     pp @score = CustomerEffortScore.new
# #   end

#   def create
#     pp "params-------------------"
#     pp params
#     # pp "customer_effort_score_params-----------------"
#     # pp customer_effort_score_params

#     # return alert: 'No tasks selected for confirmation.' if params[:customer_satisfaction].blank?

#     @score = API::CustomerEffortScore.create(
#       rating: params[:customer_satisfaction],
#       comments: params[:more_detail],
#       user_id: current_user.id
#     )

#     if @score.errors.any?
#       flash.now[:alert] = 'Feedback not submitted, please see below.'
#     #   render :
#       render_tasks_complete_with_errors
#     else
#       render :feedback_submitted
#     end
#   end

#   private

# #   def customer_effort_score_params
# #     params.require(:customer_effort_score).permit(:customer_satisfaction, :more_detail)
# #   end

#   def render_tasks_complete_with_errors
#     pp "params------================-------------"
#     pp params
#     task_ids = params[:task_ids]
#     @completed_tasks = API::Task.bulk_no_business(task_ids: task_ids)
#     @outstanding_tasks = API::Task.where(status: ['unstarted', 'in_progress', 'correcting']).all

#     render 'tasks/bulk_completed', locals: { score: @score }
#   end
# end