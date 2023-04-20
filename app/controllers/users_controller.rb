class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def index
        @users = User.all
    end

    def profile
        @user = User.find(params[:id])
        render json: {user: current_user}
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            render json: { user: @user }, status: :created
        else
            render json: { error: 'failed to create user', message: @user.errors.full_messages }, status: :not_acceptable
        end
    end

    private

    def user_params
        params.permit(:username, :password, :email)
    end

end
