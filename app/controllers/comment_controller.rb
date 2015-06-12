class CommentController < ApplicationController
  before_action :authenticate_user!
  layout false

  def show
    @comments = Comment.find_by(id: params[:id])
    if @comments.nil? or @comments.schedule_id != Integer(params[:schedule_id])
      render nothing: true, status: 404
      return
    else
      @comments = [@comments]
    end
  end

  def create
    param = create_params
    param[:user] = current_user
    param[:schedule_id] = params[:schedule_id]

    @comment = Comment.new(param)
    if not @comment.save
      errors = @comment.errors.full_messages
      render status: 400, json: errors
    else
      @comments = [@comment]
      render :show
      # redirect_to({action: 'show', id: @comment.id, schedule_id: params[:schedule_id]})
    end
  end

  def destroy
    @comments = Comment.find_by(id: params[:id])
    if @comments.nil? or @comments.schedule_id != Integer(params[:schedule_id])
      render nothing: true, status: 404
      return
    elsif @comments.user != current_user
      render nothing: true, status: 400
    else
      if @comments.destroy
        render nothing: true, status: :ok
      else
        render status: 500, json: @comments.errors.full_messages
      end
    end
  end

  def create_params
    params.require(:comment).permit(:schedule_id, :user, :content)
  end
end
