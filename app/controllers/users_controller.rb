class UsersController < ApplicationController

  def register
    @user = User.new
  end

  def show 
    @user = User.find(params[:id])
    @movies = @user.list_parties
  end

  def new
    @user = User.create(user_params)
  end
  
  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      user = user_params
      if user[:name].blank? || user[:email].blank?
        flash[:error] = "Name nor Email can be blank"
        redirect_back(fallback_location: register_path)
      else
        begin
          @user = User.create!(user_params)
          redirect_to user_path(@user.id)
        rescue ActiveRecord::RecordInvalid => e
          if e.message.include?("email")
          end
          flash[:error] = "Email is already taken. Please choose a different one."
          redirect_back(fallback_location: register_path) 
        end
      end
    else
      flash[:error] = "Passwords must match"
      redirect_back(fallback_location: register_path)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end 
end
