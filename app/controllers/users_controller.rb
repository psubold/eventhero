class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :not_signed_in,  only: :new

  def index
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
    if signed_in?
      redirect_to(root_path)
    else
    	@user = User.new(params[:user])
    	if @user.save
        sign_in @user
        UserMailer.registration_confirmation(@user).deliver
    		flash[:success] = "Welcome to EventHero!"
    		redirect_to @user 
    	else
    		render 'new'
    	end
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user 
      redirect_to @user 
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end


  private

        def signed_in_user
          unless signed_in?
            store_location
            redirect_to signin_path, notice: "Please sign in."
          end
        end

        def correct_user
          @user = User.find(params[:id])
          redirect_to(root_path) unless current_user?(@user)
        end

        def not_signed_in
          if signed_in?
            redirect_to(root_path)
          end
        end
end
