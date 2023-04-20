class AuthController < ApplicationController
  before_action :authorized, except: [:create]

  def create
    user = User.find_by(email: user_login_params[:email])
    if user && user.authenticate(user_login_params[:password])
      tokens = {
        access: issue_token(user, 'access'),
        refresh: issue_token(user, 'refresh'),
      }
      render json: {user: UserSerializer.new(user), tokens: tokens}
    else
      render json: {error: 'That user could not be found'}, status: 401
    end
  end

  def show
       user = User.find_by(id: user_id)
       if logged_in?
           render json: user
       else
           render json: { error: 'No user could be found'}, status: 401
       end
  end

  def destroy
   current_user = nil
   invalidate_token(logout_params[:refreshToken])
  end

  private
   def user_login_params
     params.permit(:email, :password)
  end

  def logout_params
    params.permit(:refreshToken)
 end


end
