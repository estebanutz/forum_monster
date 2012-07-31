class FmTopicsController < ApplicationController  
  def show
    @topic = FmTopic.find(params[:id])
    @topic.hit! if @topic
  end
  
  def new
    @forum = FmForum.find(params[:fm_forum_id])
    @topic = FmTopic.new
  end
  
  def create
    @forum = FmForum.find(params[:fm_forum_id])
    @topic = @forum.fm_topics.build(params[:fm_topic])
    @topic.user = current_user
    
    if @topic.save
      flash[:notice] = "Topic was successfully created."
      redirect_to fm_topic_url(@topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @topic = FmTopic.find(params[:id])
  end
  
  def update
    @topic = FmTopic.find(params[:id])
    
    if @topic.update_attributes(params[:fm_topic])
      flash[:notice] = "Topic was updated successfully."
      redirect_to fm_topic_url(@topic)
    end
  end

  def destroy
    @topic = FmTopic.find(params[:id])
    
    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully."
      redirect_to fm_forum_url(@topic.fm_forum)
    end
  end
end
