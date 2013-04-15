class HomeController < ApplicationController
	def index
	end 

	#bookappt 
	#param: Quote Number
	#shows available times
	def bookappt
		if params[:quote]
			@quote_number = params[:quote]['quote_number']
			@findquote = Quote.find_by_quote_number(params[:quote]['quote_number'])
			@all = Quote.all
			if !@findquote
				redirect_to :action => 'index'
			end
		end
	end

	def confirmApptRequest

	end


	

	def email_send_meeting_confirmation

		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  #:from => "Deck Hunters <deckhunters@byrobots.com>",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => "andreasoto@gmail.com",
		  :subject => "Meeting Request: A001",
		  :text => "Do you wish to confirm meeting request March 8, 2013 at 8:00am? http://OQS.heroku.com/home/confirm_client_meeting?code=A001"

		render :text => "Email sent to El Sol Construciton for confirmation" #, :layout => true
	end

	def confirm_client_meeting
		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  #:from => "OQS <deckhunters@byrobots.com>",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => "andreasoto@gmail.com",
		  :subject => "Meeting Request: A001 - Accepted",
		  :text => "Thanks for contacting us!  "

		render :text => "Email sent to client. Please check your calendar" #, :layout => true
		#redirect_to :action => 'icalendar_generator'
	end

	def icalendar_generator
		#multiple events test
		cal = Icalendar::Calendar.new
		cal.event do
		  dtstart       Date.new(2013, 03, 29)
		  dtend         Date.new(2013, 03, 30)
		  summary     "Meeting with the YUI."
		  description "Have a long lunch meeting and decide nothing..."
		  klass       "PRIVATE"
		end

		event = Icalendar::Event.new
		event.start = DateTime.civil(2013, 3, 10, 8, 30)#year month day hour min
		event.summary = "A great event1!"
		cal.add_event(event)

		event = Icalendar::Event.new
		event.start = DateTime.civil(2013, 3, 8, 8, 00)#year month day hour min
		event.dtend = DateTime.civil(2013, 3, 8, 9, 00)#year month day hour min
		event.summary = "A great event!2"
		cal.add_event(event)

		render :text => cal.to_ical

	end

	def bookappt_before
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

			#we verify code then we send email
			redirect_to :action => 'confirmation'
		else
			#@findquote = " No quote found"
			#@quote_number = " No quote number"
			#html part
			#				<p>
			#		<h4>Debugging information:</h4>
			#	<ul>
			#	<% Quote.all.each do |q| %>
			#		<li><%= q.name %> : <%= q.quote_number %></li>
			#		<li><%= q.email %> : <%= q.cell %></li>
			#	<% end %>
			#	</ul>
			#
			#		<h4>Quote Code Found:<%= @findquote.email %></h4>
			#		<h4>Quote_NumberInput:<%= @quote_number %></h4>

		end
	end

end
