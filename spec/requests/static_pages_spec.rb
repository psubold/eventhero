require 'spec_helper'

describe "Static page" do 

	describe "Home page" do 

		it "should have 'Home' in title" do 
			visit '/static_pages/home'
			page.should have_selector('title',
						:text => "| Home")
		end

	end

	describe "About page" do 

		it "should have 'About' in title" do 
			visit '/static_pages/about'
			page.should have_selector('title',
						:text => "| About Us")
		end
	end


	describe "contact page" do 

		it "should have 'contact us' in title" do 
			visit '/static_pages/contact'
			page.should have_selector('title',
						:text => "| Contact Us")
		end
	end


	describe "how it works page" do 

		it "shoudl have 'how it works' in title" do 
			visit '/static_pages/howitworks'
			page.should have_selector('title',
						:text => "| How It Works")
		end
	end


end