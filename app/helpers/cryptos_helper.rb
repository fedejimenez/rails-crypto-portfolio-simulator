module CryptosHelper
  def current_coin(symbol)
 		for c in @coins
      if symbol == c["symbol"]
      	return c
      end
  	end
  end

  def calculate_quantity
    if @crypto.last_action == "Sell"
      @crypto.amount_owned = @crypto.amount_owned - @crypto.last_transaction
      @crypto.sell(params[:crypto][:amount_owned])
    elsif @crypto.last_action == "Buy"
      @crypto.amount_owned = @crypto.amount_owned + @crypto.last_transaction
      @crypto.buy(params[:crypto][:amount_owned])
    end
    @crypto.save
  end

  def update_portfolio_balance
    @portfolio = Portfolio.where(user_id: current_user.id).first
    if @crypto.last_action == "Sell"
      @portfolio.balance = @portfolio.balance + (@crypto.cost_per * @crypto.last_transaction)
    elsif @crypto.last_action == "Buy"
      @portfolio.balance = @portfolio.balance - (@crypto.cost_per * @crypto.last_transaction)
    end
    @portfolio.save
  end

  def check_amount_available
    @portfolio = Portfolio.where(user_id: current_user.id).first
    if @crypto.amount_owned == nil
      amount_to_buy = @crypto[:amount_owned]
    else
      amount_to_buy = @crypto[:last_transaction]
    end
    quantity_to_sell = @crypto[:last_transaction]
    price = @crypto[:cost_per]

    begin
      if (@portfolio.balance - (amount_to_buy*price) < 0 ) || (@crypto.amount_owned - @crypto[:last_transaction] < 0) 
        # cancel save (if balance < 0 when buying or quantity <  0 when selling)
        throw :abort
      end
    rescue UncaughtThrowError => e
        flash[:warning] = "It is not possible to complete the transaction, check the amount and quantity entered."
        redirect_to portfolio_cryptos_url(current_portfolio.id) 
    end
  end

end
