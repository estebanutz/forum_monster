class FmForumsController < ApplicationController    
  def show
    @forum = FmForum.find(params[:id])
  end
  
  def new
    @forum = FmForum.new
  end
  
  def create
    @forum = FmForum.new(params[:fm_forum])
    
    if @forum.save
      flash[:notice] = "Forum was successfully created."
      redirect_to fm_forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = FmForum.find(params[:id])
  end
  
  def update
    @forum = FmForum.find(params[:id])
    
    if @forum.update_attributes(params[:fm_forum])
      flash[:notice] = "Forum was updated successfully."
      redirect_to fm_forum_url(@forum)
    end
  end
  
  def destroy
    @forum = FmForum.find(params[:id])
    
    if @forum.destroy
      flash[:notice] = "Category was deleted."
      redirect_to fm_forums_url
    end
  end
end