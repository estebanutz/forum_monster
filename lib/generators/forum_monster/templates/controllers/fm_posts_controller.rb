class FmPostsController < ApplicationController    
  def new
    @topic = FmTopic.find(params[:fm_topic_id])
    @post = FmPost.new
    
    if params[:quote]
      quote_post = FmPost.find(params[:quote])
      if quote_post
        @post.body = quote_post.body
      end
    end
  end
  
  def create
    @topic = FmTopic.find(params[:fm_topic_id])
    @post = @topic.fm_posts.build(params[:fm_post])
    @post.fm_forum = @topic.fm_forum
    @post.user = current_user
    
    if @post.save
      flash[:notice] = "Post was successfully created."
      redirect_to fm_topic_path(@post.fm_topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = FmPost.find(params[:id])
  end
  
  def update
    @post = FmPost.find(params[:id])

    if @post.update_attributes(params[:fm_post])
      flash[:notice] = "Post was successfully updated."
      redirect_to fm_topic_path(@post.fm_topic)
    end
  end
  
  def destroy
    @post = FmPost.find(params[:id])
    
    if @post.fm_topic.fm_posts_count > 1
      if @post.destroy
        flash[:notice] = "Post was successfully destroyed."
        redirect_to fm_topic_path(@post.fm_topic)
      end
    else
      if @post.fm_topic.destroy
        flash[:notice] = "Topic was successfully deleted."
        redirect_to fm_forum_path(@post.fm_forum)
      end
    end
  end
end