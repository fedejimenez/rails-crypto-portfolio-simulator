class CryptosController < ApplicationController
  include CryptosHelper
  include PortfoliosHelper

  before_action :set_crypto, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :correct_user, only: [:edit, :update, :destroy, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  after_action :calculate_quantity, only: [:update]
  after_action :update_portfolio_balance, only: [:update, :create]

  # GET /cryptos
  # GET /cryptos.json
  def index
  end

  # GET /cryptos/1
  # GET /cryptos/1.json
  def show
  end

  # GET /cryptos/new
  def new
    @crypto = Crypto.new
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
    check_amount_available
    respond_to do |format|
      if @crypto.buy(params[:crypto][:quantity].to_i)
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id), :flash => { :success => "A new currency #{@crypto.symbol} was successfully added into the Portfolio." }}
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
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id) }
        format.json { render :show, status: :ok, location: @crypto }
      else
        format.html { render :edit, notice: 'Error while processing the transaction. Please check your balance and the quantity.' }
        format.json { render json: @crypto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cryptos/1
  # DELETE /cryptos/1.json
  def destroy
    @crypto.destroy
    respond_to do |format|
      if @crypto.sell(params[:crypto][:amount_owned].to_i)
        format.html { redirect_to portfolio_cryptos_url(current_portfolio.id), notice: 'Crypto was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
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
      if @correct.nil?
        flash[:warning] = "Oops! You're not Authorized to view or edit this page! " 
        redirect_to cryptos_path
      end
    end

    def handle_record_not_found
      flash[:warning] = "Oops! You're not Authorized to view or edit this page! "
      redirect_to cryptos_path
    end
end
