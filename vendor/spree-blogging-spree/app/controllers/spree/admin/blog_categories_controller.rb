class Spree::Admin::BlogCategoriesController < Spree::Admin::BaseController
  before_action :tagging, :only => [:edit, :update]

  def index
    @blog_categories = Spree::BlogEntry.tag_counts_on(:categories)
  end

  def edit
    unless @blog_category
      flash[:error] = 'Blog category was not found'
      return redirect_to admin_blog_categories_index_path
    end
  end

  def update
    if params[:acts_as_taggable_on_tag][:name].present?
      @blog_category.name = params[:acts_as_taggable_on_tag][:name]
      @blog_category.save
      flash[:success] = 'Blog category has been updated successfully'
      return redirect_to admin_blog_categories_index_path
    else
      flash[:error] = 'Blog category name is required'
      return redirect_to admin_blog_categories_index_path
    end
  end

  def tagging
    @blog_category = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def update_featured
    if params[:category_id].present? && params[:val].present?
      count_blog_category = Spree::BlogEntry.tag_counts_on(:categories).where(:featured => true).count
      if count_blog_category >= 3 && params[:val].to_i == 1
        render :json => {:num_featured => count_blog_category} and return
      end
      category = ActsAsTaggableOn::Tag.find(params[:category_id])
      if category.present?
        category.update_attribute(:featured, params[:val])
        render :nothing => true, :status => 200, :content_type => 'text/html'
      end
    end
  end
end