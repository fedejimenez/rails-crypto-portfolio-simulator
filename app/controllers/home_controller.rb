class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper

  def index
    get_data_from_API
  end

  def about 
  end

  def search
    get_data_from_API
    respond_to do |format|
      format.html {
        @search = params[:q].upcase
        if @search == ""
          @search = "The search field can't be empty"
        end
      }
      format.json {
        render json: @coins
      }
    end
  end
end
