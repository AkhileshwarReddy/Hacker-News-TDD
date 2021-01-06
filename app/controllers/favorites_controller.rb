class FavoritesController < ApplicationController
    before_action :set_params, only: [:index, :favorites]

    def index
        @user = User.find(current_user.id)
        @comment == "t" ? set_favorite_comment : set_favorite_submission
        @user.save
        redirect_to request.referrer
    end

    def favorites
        @user = User.find_by(username: @id)
        @comment == "t" ? favorite_comments : favorite_submissions
    end

    private
        def set_params
            @id = params[:id]
            @comment = params[:comment]
            @how = params[:how]
        end

        def set_favorite_comment
            comment = Comment.find(@id)
            if @how == "un"
                FavoriteComment.delete_by(user: @user, item_id: comment.id)
            else
                favorite_comment = FavoriteComment.new(item_id: comment.id, user: @user)
                favorite_comment.save
            end
        end

        def set_favorite_submission
            submission = Submission.find(@id)
            if @how == "un"
                FavoriteSubmission.where(user: @user).delete(submission.id)
            else
                favorite_submission = FavoriteSubmission.new(item_id: submission.id, user: @user)
                favorite_submission.save
            end
        end

        def favorite_submissions
            @submissions = Submission.where(id: Favorite.submissions(@user))
            render "favorites/submissions"
        end

        def favorite_comments
            @comments = Comment.where(id: Favorite.comments(@user))
            render "favorites/comments"
        end
end
