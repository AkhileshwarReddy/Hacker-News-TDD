class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    before_action :set_user, only: [:update]

    def user
        if params[:id] == nil
            flash[:alert] = "No such user"
        else
            if user_signed_in? and params[:id] == current_user.username
                @user = current_user
            else
                @user = User.find_by(username: params[:id])
            end
        end
    end

    def update
        @user.update(user_params)
        redirect_to user_path(:id => @user.username)
    end

    private
        def user_params
           params.require(:user).permit(:about, :email, :showdead, :noprocrast, :max_visit, :minaway, :delay)
        end

        def set_user
            @user = User.find_by(username: params[:user][:username])
        end
end
