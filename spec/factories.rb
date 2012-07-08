FactoryGirl.define do 
	factory :user do 
		email		"scott.bold@gmail.com"
		password	"foobar"
		password_confirmation  "foobar"
	end
end