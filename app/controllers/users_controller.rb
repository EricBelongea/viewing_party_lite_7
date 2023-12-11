class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique, with: :not_unique_response

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
    # require 'pry'; binding.pry
    if params[:user][:password] == params[:user][:password_confirmation]
      user = user_params
      if user[:name].blank? || user[:email].blank?
        flash[:error] = "Name nor Email can be blank"
        redirect_back(fallback_location: register_path)
      else
        @user = User.create!(user_params)
      end
      require 'pry'; binding.pry
    else
      flash[:error] = "Passwords must match"
      redirect_back(fallback_location: register_path)
    end
    require 'pry'; binding.pry
    redirect_to user_path(@user)
    # if @user.name.blank? || @user.email.blank?
    #   flash[:alert] = 'Name or Email cannot be blank'
    #   redirect_back(fallback_location: new_user_path)
    # else
    #   begin
    #     @user.save!
    #     redirect_to user_path(@user.id)
    #   rescue ActiveRecord::RecordNotUnique => e
    #     if e.message.include?('email')
    #       flash[:alert] = 'Email is already taken. Please choose a different one.'
    #     end
    #     redirect_back(fallback_location: new_user_path)
    #   end
    # end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end 

  def not_unique_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end
end
