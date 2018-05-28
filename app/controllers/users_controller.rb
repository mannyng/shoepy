class UsersController < ApplicationController
    before_action :authenticate_request!, only: [:index,:show]
  
  def login
   @email = params[:email].downcase
  command = AuthenticateUser.call( @email, params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def confirm
   token = params[:token].to_s

   user = User.find_by(confirmation_token: token)

   if user.present? && user.confirmation_token_valid?
    if user.confirmed_at?
     user.mark_as_confirmed!
     render json: {status: 'User confirmed successfully'}, status: :ok
    else
     render json: {error: 'Email not verified' }, status: :unauthorized
    end
   else
    render json: {status: 'Invalid token'}, status: :not_found
   end
  end
   def new
   end
   def create
      user = User.new(user_params)
      user.password =params[:password]
      user.password_confirmation = params[:password_confirmation]
    if user.save!
        @email = params[:email].downcase
        command = AuthenticateUser.call( @email, params[:password])

        if command.success?
          render json: { auth_token: command.result }, status: :created
         else
          render json: { error: command.errors }, status: :unauthorized
        end
      #render json: {user: user, status: 'User created successfully'}, status: :created
      else
       render json: { errors: user.errors.full_messages }, status: :bad_request
    end
   end
   
   def show
     user = User.find(params[:id])
     user_info = {email: user.email, user_type: user.user_type}
     render json: user, status: :ok
     #render json: {user: user}
   end
   def my_line_items
     user = User.find(params[:id])
     my_items = user.line_items
     items = []
     my_items.each do |item|
         items << item.product
     end
     
     render json: items, status: :ok
   end 
   def user_type
        user = User.find(params[:id])
        user_info = user.user_type
        
        render json: user_info, status: :ok
    end
   def index
     users = User.all
     
     render json: users, status: :ok
   end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
