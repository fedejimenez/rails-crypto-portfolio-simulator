class SearchesController < ApplicationController
    before_action :calculate_profit

	def new
		@search = Search.new
	end	

	def create
		@search = Search.create(search_params)
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])

		# Search advanced
		@search_filtered = Kaminari.paginate_array([@search.advanced_search], total_count: @search.advanced_search.count).page(params[:page]).per(10)

	end

	private
	def search_params
		params.require(:search).permit(:keywords, :categories, :min_price, :max_price, :rank, :symbol, :name, :id_crypto, :percent_change_1h, :percent_change_24h, :percent_change_27d, :volume_24h_usd, :market)
	end
end
