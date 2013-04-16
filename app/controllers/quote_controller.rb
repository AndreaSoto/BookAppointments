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
		#
		@quote.save
		# TODO: send email

		
		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => "andreasoto@gmail.com",
		  :subject => "Quote needs approval",
		  :text => "

		  	http://OQS.heroku.com/quote/confirm_quote?code=".concat(@quote.id.to_s).concat("

		  	").concat(@quote.inspect)


		# redirect_to :action => 'create' if 
		render :text => params
		# logger.debug @quote.inspect
	end

	def confirm_quote
		quote = Quote.find(params[:code])
		height = quote.h_inches / 12 + quote.h_feet
		width = quote.w_inches / 12 + quote.w_feet
		length = quote.l_inches / 12 + quote.l_feet



		calc = 2 * ( height * length) + 2 * (height * width)

		if (quote.ceiling == 1) then
			calc = calc + (length * width)
		end

		if (quote.insulated == 1) then
			total = calc * 6.5
		else
			total = calc * 8
		end

		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => "andreasoto@gmail.com",
		  :subject => "Autogenerated quote",
		  :text => "Total : $".concat(total.to_s).concat("
		  	The price includes the drywall, taping, texture and attic insulation.

		  	If you would like to book an appointment, please visit: http://OQS.heroku.com/ and use the code:
		  	").concat(quote.quote_number)
		render :text => "The quote has been sent."
		
	end
end
