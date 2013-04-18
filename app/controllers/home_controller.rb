class HomeController < ApplicationController


	def index
	end 

	#bookappt 
	#param: Quote Number
	#shows available times
	def bookappt
		@times = times
		if params[:quote]
			@quote_number = params[:quote]['quote_number']
			@findquote = Quote.find_by_quote_number(params[:quote]['quote_number'])
			@all = Quote.all
			if !@findquote
				flash[:error] = "Quote number not found or already used."
				redirect_to root_url
			end
		end
	end

	def confirm_appointment

		ap = Appointment.new
		ap.quote = Quote.find_by_id(params[:appointment]["quote_id"])

		# hacky way to find the index I need.
		datetime = ""
		(times).each do |i, j|
			#logger.debug i
			if (params.index(j) != nil)
				datetime = params.index(j)
			end
		end

		#at this point datetime has the correct value, we just need to split it.
		datetime = datetime.split(/__/)

		ap.day = datetime[0]
		ap.time = datetime[1]
		ap.location = params[:appointment]["location"]
		ap.save

		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => "andreasoto@gmail.com",
		  :subject => "Meeting Request: ".concat(ap.quote.quote_number),
		  :text => "Do you wish to confirm meeting request ".concat(datetime[0].to_s).concat(" at ").concat(datetime[1].to_s).concat("? http://OQS.heroku.com/home/confirm_client_meeting?code=").concat(ap.quote.quote_number)

		flash[:notice] = "Appointment successfuly created. Please wait for an email confirmation."

		redirect_to root_url #if a.save

	end

	# def email_send_meeting_confirmation
	# 	quote = Quote.find_by_quote_number(params[:code])
	# 	RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
	# 	  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
	# 	  :from => "OQS <andreasoto@gmail.com>",
	# 	  :to => "andreasoto@gmail.com",
	# 	  :subject => "Meeting Request: ".concat(quote.quote_number),
	# 	  :text => "Do you wish to confirm meeting request March 8, 2013 at 8:00am? http://OQS.heroku.com/home/confirm_client_meeting?code=".concat(quote.quote_number)

	# 	render :text => "Email sent to El Sol Construciton for confirmation" #, :layout => true
	# end

	def confirm_client_meeting
		quote = Quote.find_by_quote_number(params[:code])
		RestClient.post "https://api:key-857bcl2hvwsj340zb-ov9h2xd4cfj9e3"\
		  "@api.mailgun.net/v2/app2743556.mailgun.org/messages",
		  :from => "OQS <andreasoto@gmail.com>",
		  :to => quote.email,
		  :subject => "Meeting Request Accepted: ".concat(quote.quote_number),
		  :text => "Thanks for contacting us!  The meeting was confirmed."

		render :text => "<h3>Email sent to client. Please check your calendar</h3>" #, :layout => true
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


	private 

	def times
		times = {}
		times["8"] = "8am to 9pm"
		times["9"] = "9am to 9pm"
		times["10"] = "10am to 9pm"
		times["6"] = "6am to 9pm"
		times["7"] = "7am to 9pm"
		return times
	end

end
