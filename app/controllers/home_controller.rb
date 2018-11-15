class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper
  include UsersHelper
  include PortfoliosHelper

  before_action :calculate_profit, except: [:landing]
  before_action :get_monthly_from_API, only: [:home, :index]
  before_action :get_historical_from_API, only: [:home, :index]
  
  def index
  end

  def about 
  end

  def landing
    if logged_in?
      redirect_to home_path, turbolinks: false
    end
  end

  def home
    if !logged_in?
      redirect_to root_path, turbolinks: false
    end
  end

  def lookup
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
