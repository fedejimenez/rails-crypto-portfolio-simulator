class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper
  include PortfoliosHelper

  def index
    get_data_from_API
    current_portfolio
  end

  def about 
  end

  def lookup
    get_data_from_API
    @crypto = Crypto.all
    respond_to do |format|
      format.html {
        @lookup = params[:q].upcase
        if @lookup == ""
          @lookup = "The search field can't be empty"
        end
      }
      format.json {
        render json: @coins
      }
    end
  end
end
