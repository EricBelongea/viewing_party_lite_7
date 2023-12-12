class UsersController < ApplicationController
  # rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  def register
    @user = User.new
  end

  def login_form
  end

  def login_user
    require 'pry'; binding.pry
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad"
      render :login_form
    end
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
          @user = User.create!(user)
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

  # def invalid_response
  #   # flash[:error] = "Email is already taken. Please choose a different one."
  #   flash[:error] = "This will catch everything."
  #   redirect_back(fallback_location: register_path)
  # end
end
