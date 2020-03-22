class UsersController < ApplicationController

    skip_before_action :check_authentication, only: [:create, :show, :index, :destroy, :update] 

    def index
        users = User.all
        render json: users.to_json()
    end
    
    def show 
        user = User.find_by(id: params[:id])
        render json: user.to_json()
    end

    def create 
        user = User.new(user_params)
        if user.valid? 
            user.save
            render json: {user: UserSerializer.new(user)}
        else
            render json: { error: "Fail to create user"}
        end
    end

    def destroy 
        user = User.find(params[:id])
        user.destroy
        render json: {message: "User: #{user.username} has been deleted"}
    end

    def update 
        user = User.find(params[:id])
        user.update(user_params)
        render json: { user: UserSerializer.new(user) }
    end

    private

    def user_params
        params.permit(:username, :password)
    end

end
