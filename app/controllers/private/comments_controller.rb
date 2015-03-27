class Private::CommentsController < ApplicationController
  filter_access_to :all

  def create
    comment = Comment.new params[:comment]

    if comment.save
      flash[:success] = "Comment saved"
    else
      flash[:error] = "Please write comment's text"
    end

    redirect_to :back
  end

  def add_comment
    @job = Job.find(params[:job_id])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
