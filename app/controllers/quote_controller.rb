class QuoteController < ApplicationController

	def index
		
	end

	def create
		
		@quote = Quote.new

	end

	def create_save
		require 'securerandom'
		@quote = Quote.create(params[:quote])
		@quote.quote_number = SecureRandom.hex(2).upcase.reverse

		# TODO: Calcualtion has to happen here.


		# TODO: send email

		

		redirect_to :action => 'create' if @quote.save
		# logger.debug @quote.inspect
	end
end
