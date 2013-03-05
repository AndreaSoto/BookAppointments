class HomeController < ApplicationController
	def index 
		
	end 
	def bookappt
		#@new_appt = Appointment.new
		#@new_quote = Quote.new
		#@quote = 
		#@findquote = Quote.new
		#@result = Quote.where("quote_number = ?",params[:quote_number])
		#@result.save

		if params[:quote]
			#@findquote = Quote.find(:all, :conditions => ['quote_number LIKE', "%#{params[:quote_number]}%"])
			
			@quote_number = params[:quote]['quote_number']
			#@findquote = Quote.find(:all, :conditions => ['quote_number LIKE', "%#{params[:quote]}%"])
			#@findquote = Quote.where("quote_number = ?", params[:quote]).first
			#@findquote = Quote.find(:conditions => {:quote_number => params[:quote]['quote_number']})
			@findquote = Quote.find_by_quote_number(params[:quote]['quote_number'])
		else
			@findquote = " No quote found"
			@quote_number = " No quote number"
		end
	end
end
