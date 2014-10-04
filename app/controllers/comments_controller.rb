class CommentsController < ApplicationController
before_action :require_user
def create 
  
  @post = Post.find(params[:post_id])
  @comment = Comment.new(comment_params)
  @comment.post = @post 
  @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment has been created"
      redirect_to posts_path(@post) 

    else 
      render 'posts/show' 
    end 

  end 

  def vote
    comment = Comment.find(params[:id])

    comment = Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
    
    if comment.valid? 
    flash[:notice] = "Your vote was counted" 
    redirect_to  :back
    
    else
    flash[:error] = "You can only vote once"
    redirect_to :back
    end 
  end 

  private

  def comment_params
    params.require(:comment).permit(:body)
    
  end

end 
 