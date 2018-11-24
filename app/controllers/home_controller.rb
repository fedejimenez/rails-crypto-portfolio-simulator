class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper
  include UsersHelper
  include PortfoliosHelper

  before_action :authorize, except: [:landing]
  before_action :calculate_profit, except: [:landing]
  before_action :update_ranking, except: [:landing, :lookup]
  before_action :get_historical_from_API, only: [:home, :index]


  def index
    @breadcrumb_title = ' TOP 50 CRYPTOS OF THE DAY'
    @breadcrumb_icon = 'list-alt'
    @breadcrumb_subtitle = ''
    @breadcrumb_path1 = ''
    @breadcrumb_link1 = ''
    @breadcrumb_current = 'Top 50'
  end
  
  def ranking
    @breadcrumb_title = " RANKING"
    @breadcrumb_icon = 'trophy'
    @breadcrumb_subtitle = ''
    @breadcrumb_path1 = ''
    @breadcrumb_link1 = ''
    @breadcrumb_current = 'Ranking'
  end

  def about 
  end

  def suggestions
    @comment = Comment.new
    @breadcrumb_title = " SUGGESTIONS"
    @breadcrumb_icon = 'send'
    @breadcrumb_subtitle = ''
    @breadcrumb_path1 = ''
    @breadcrumb_link1 = ''
    @breadcrumb_current = 'Suggestions'
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
    get_data_from_API
    if params[:q]
      @breadcrumb_title = " TOP 50 - " + params[:q]
      @breadcrumb_icon = 'search'
      @breadcrumb_subtitle = ''
      @breadcrumb_path1 = 'Top 50'
      @breadcrumb_link1 = '/home/index'
      @breadcrumb_current = ''+params[:q]
    end
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
