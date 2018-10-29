class CryptosController < ApplicationController
  before_action :set_crypto, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :correct_user, only: [:edit, :update, :destroy, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  before_action :calculate_quantity, only: [:update]
  after_action :update_portfolio_balance, only: [:update, :create]


  include CryptosHelper
  include PortfoliosHelper
  # GET /cryptos
  # GET /cryptos.json
  def index
    @cryptos = Crypto.all
    get_data_from_API
  end

  # GET /cryptos/1
  # GET /cryptos/1.json
  def show
  end

  # GET /cryptos/new
  def new
    get_data_from_API
    @crypto = Crypto.new
    @cryptos = Crypto.all
  end

  # GET /cryptos/1/edit
  def edit
  end

  # POST /cryptos
  # POST /cryptos.json
  def create
    @crypto = Crypto.new(crypto_params)
    @crypto.last_transaction ||= @crypto.amount_owned
    @crypto.portfolio_id = current_portfolio.id
    respond_to do |format|
      # if @crypto.save
      if @crypto.buy(params[:crypto][:quantity].to_i)
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id), notice: 'Crypto was successfully created.' }
        format.json { render :show, status: :created, location: @crypto }
      else
        format.html { render :new }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cryptos/1
  # PATCH/PUT /cryptos/1.json
  def update
    respond_to do |format|
      if @crypto.update(crypto_params)
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id), notice: 'Crypto was successfully updated.' }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  def calculate_quantity
    @crypto.amount_owned = @crypto.amount_owned + @crypto.last_transaction
  end

  def update_portfolio_balance
    @portfolio = Portfolio.where(user_id: current_user.id).first
    @portfolio.balance = @portfolio.balance - @crypto.cost_per
    @portfolio.save
  end

  # DELETE /cryptos/1
  # DELETE /cryptos/1.json
  def destroy
    @crypto.destroy
    respond_to do |format|
      if @crypto.sell(params[:crypto][:quantity].to_i)
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id), notice: 'Crypto was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def buy 
    @crypto = @portfolio.buy(params[:crypto][:symbol], params[:crypto][:quantity].to_i)
  end
  def sell 
    @crypto = @portfolio.sell(params[:crypto][:symbol], params[:crypto][:quantity].to_i)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crypto
      @crypto = Crypto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crypto_params
      params.require(:crypto).permit(:symbol, :user_id, :cost_per, :amount_owned, :last_transaction, :last_action, :portfolio_id)
    end

    def correct_user
      @correct = current_user.cryptos.find_by(id: params[:id])
      redirect_to cryptos_path, notice: "Oops! You're not Authorized to view or edit this page! " if @correct.nil?
    end

    def handle_record_not_found
      redirect_to cryptos_path, notice: "Oops! You're not Authorized to view or edit this page" 
    end
end
