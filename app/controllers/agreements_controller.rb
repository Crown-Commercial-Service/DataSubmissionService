class AgreementsController < ApplicationController
  def index
    @agreements = API::Agreement.includes(:framework, :supplier).all
  end
end
