module Messaging
  class CommentsController < ApplicationController
    def create
      @comment = Messaging::Comment.new(allowed_params)
      @comment.user_id = current_user.id

      if @comment.save
        redirect_back(fallback_location: root_path, notice: t('messaging.comments.create.success'))
      else
        redirect_back(fallback_location: root_path, alert: t('messaging.comments.create.empty'))
      end
    end

    def update
      @comment = Messaging::Comment.find(params[:id])

      if @comment.update(allowed_params)
        redirect_back(fallback_location: root_path, notice: t('messaging.comments.update.success'))
      else
        redirect_back(fallback_location: root_path, alert: t('messaging.comments.update.error'))
      end
    end

    def destroy
      comment = Messaging::Comment.find(params[:id])

      comment.destroy
      redirect_back(fallback_location: root_path, notice: t('messaging.comments.destroy.success'))
    end

    private

    def allowed_params
      params.require(:messaging_comment).permit(:content, :commentable_type, :commentable_id)
    end
  end
end
