class AgreementsController < ApplicationController
  def index
    @agreements = API::Agreement.includes(:framework, :supplier)
                                .where(active: params[:status])
                                .all
                                .sort_by! { |t| t.framework.name }
  end
end
