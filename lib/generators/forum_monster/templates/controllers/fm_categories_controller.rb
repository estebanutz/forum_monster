class FmCategoriesController < ApplicationController  
  def index
    @categories = FmCategory.all
  end
  
  def new
    @category = FmCategory.new
  end
  
  def create
    @category = FmCategory.new(params[:category])
    
    if @category.save
      flash[:notice] = "Category was successfully created."
      redirect_to fm_forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = FmCategory.find(params[:id])
  end
  
  def update
    @category = FmCategory.find(params[:id])
    
    if @category.update_attributes(params[:fm_category])
      flash[:notice] = "Category was updated successfully."
      redirect_to fm_forums_url
    end
  end
  
  def destroy
    @category = FmCategory.find(params[:id])
    
    if @category.destroy
      flash[:notice] = "Category was deleted."
      redirect_to fm_forums_url
    end
  end
end