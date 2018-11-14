class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper
  include PortfoliosHelper

  before_action :calculate_profit
  
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
      redirect_to root, turbolinks: false
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
