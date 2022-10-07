class AgreementsController < ApplicationController
  def index
    @agreements = API::Agreement.includes(:framework, :supplier)
                                .where(active: params[:status])
                                .all
  end
end
