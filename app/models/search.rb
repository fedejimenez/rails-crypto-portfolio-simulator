class Search < ApplicationRecord
  include ApplicationHelper

	def advanced_search
    get_data_from_API
    # @coins = @coins.where(["symbol LIKE ?", "%#{keywords}"]) if keywords.present?
    # @coins = @coins.where(["price_usd >= ?", min_price]) if min_price.present?

    # @coins_filtered = @coins.select {|c| c["symbol"] == symbol.upcase } if symbol.present?
    if min_price.present? && max_price.present?
    	@coins_filtered = @coins.select {
    		|c| (c['quote']['USD']['price'].to_d > min_price.to_d && c['quote']['USD']['price'].to_d < max_price.to_d)
    	} 
    else 
    	@coins_filtered = @coins.select {|c| c['quote']['USD']['price'].to_d > min_price.to_d } if min_price.present?
    	@coins_filtered = @coins.select {|c| c['quote']['USD']['price'].to_d < max_price.to_d } if max_price.present?
    end

  	@coins_filtered = @coins.select {|c| c['quote']['USD']['percent_change_1h'].to_d.round(2) > percent_change_1h.to_d.round(2) } if percent_change_1h.present?
  	@coins_filtered = @coins.select {|c| c['quote']['USD']['percent_change_24h'].to_d.round(2) > percent_change_24h.to_d.round(2) } if percent_change_24h.present?
  	@coins_filtered = @coins.select {|c| c['quote']['USD']['percent_change_7d'].to_d.round(2) > percent_change_7d.to_d.round(2) } if percent_change_7d.present?

    return @coins_filtered
	end

  # Search Kaminari Pagination
  def self.search(term, page)
    if term
      where('name LIKE ?', "%#{term}%").order('id DESC').page(current_page)
    else
      # note: default is all, just sorted
      order('id DESC').page(current_page) 
    end
  end
end
