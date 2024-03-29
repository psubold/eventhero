require 'spec_helper'

describe User do

	before do 
		@user = User.new(email: "user@example.com",
						password: "foobar",
						password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:password) }
	it { should respond_to(:authenticate) }

	it { should be_valid }

	describe "when email is empty" do 
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email is already taken" do 
		before do 
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end




	describe "when password is empty" do 
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password is too short" do 
		before { @user.password = "a" * 5 }
		it { should_not be_valid }
	end

	describe "when password does not equal password_confirmation" do 
		before { @user.password = "FOObar" }
		it {should_not be_valid}
	end

	describe "return value of authenticate method" do 
		before {@user.save}
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do 
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do 
			let(:user_with_bad_pass) { found_user.authenticate("badpass")}

			it { should_not == user_with_bad_pass }
			specify { user_with_bad_pass.should be_false }
		end
	end





end
