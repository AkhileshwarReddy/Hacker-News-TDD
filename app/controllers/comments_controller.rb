class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :set_comment, only: [:create]

    def create
        if params[:is_comment] == "true"
            parent_comment = Comment.find(params[:id])
            @submission = Submission.find(parent_comment.submission.id)
        else
            @submission = Submission.find(params[:id])
        end
        @comment.submission = @submission;
        @comment.level = (@submission.comments.where(parent_comment_id: nil).count.to_i + 1).to_s
        @comment.save
        redirect_to item_url(:id => params[:id])
    end

    def reply
        Comment.create_child_comment(params[:content], params[:id], current_user)
        redirect_to request.referrer
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def new_comments
        @comments = Comment.order(created_at: :desc)
    end

    def threads
        @comments = Comment.threads(current_user)
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end

        def set_comment
            @comment = Comment.new(comment_params)
            @comment.user = current_user
        end
end
