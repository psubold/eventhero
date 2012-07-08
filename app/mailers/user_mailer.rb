class UserMailer < ActionMailer::Base
	def registration_confirmation(user)
		@user=user 
		mail(to: user.email, subject: "Welcome to EventHero!", from: "eventheroapp@gmail.com")
	end
end
