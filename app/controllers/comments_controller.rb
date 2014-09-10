class CommentsController < ApplicationController

def create 
  
  @post = Post.find(params[:post_id])
  @comment = Comment.new(comment_params)
  @comment.post = @post 
  @comment.creator = User.find(3) #temp

    if @comment.save
      flash[:notice] = "Your comment has been created"
      redirect_to posts_path(@post) 

    else 
      render 'posts/show' 
    end 

  end 

  private

  def comment_params
    params.require(:comment).permit(:body)
    
  end

end 
 