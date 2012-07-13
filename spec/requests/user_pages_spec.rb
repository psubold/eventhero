require 'spec_helper'

describe "User Pages" do 

	subject {page}


	describe "Profile Page" do 
		let(:user) {FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('title', text: user.name) }
	end

	describe "signup" do 
		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do 
			it "should not create a user" do 
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid info" do
			before do 
				fill_in "Email",        with: "user@example.com"
        		fill_in "Password",     with: "foobar"
        		fill_in "Confirmation", with: "foobar"
        	end

			it "should create user" do 
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end

	end

	describe "visiting signup page when signed in" do 
		let(:user) {FactoryGirl.create(:user) }
		before do 
			sign_in user 
			visit signup_path
		end

		it { should have_selector('title', text: "Home") }

	end

	describe "attempting to create user when signed in" do 
		let(:user) {FactoryGirl.create(:user) }
		before do 
			sign_in user
			post users_path
		end

		specify { response.should redirect_to(root_path) }
	end

	describe "Edit" do 
		let (:user) {FactoryGirl.create(:user) }
		before do 
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do 
			it { should have_link('change', href: 'http://gravatar.com/emails')}
		end

		describe "with invalid info" do 
			before { click_button "Save changes" }

			it { should have_content('error') }
		end
	end


	##describe "admins destroying themselves" do 
	##	let(:user) {FactoryGirl.create(:user) }
	##	before do 
	##		user.toggle!(:admin)
	##		sign_in user 
	##	end
##
#		describe "should not be allowed" do 
#			before { delete user_path(user) }
#			specify { response.should }



end