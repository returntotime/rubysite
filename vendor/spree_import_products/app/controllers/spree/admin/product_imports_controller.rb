class Spree::Admin::ProductImportsController < Spree::Admin::BaseController

  require 'csv'
  #Sorry for not using resource_controller railsdog - I wanted to, but then... I did it this way.
  #Verbosity is nice?
  #Feel free to refactor and submit a pull request.

  def index
    respond_to do |format|
      format.html { redirect_to :action => :new }
      format.csv { send_data generate_to_csv }
    end
#    redirect_to :action => :new
  end

  def new
    @product_import = ProductImport.new
    @csv_files = Dir.glob("#{Rails.root}/lib/etc/product_data/data-files/**/*")
    respond_to do |format|
      format.html
      format.csv { send_data generate_to_csv }
    end
  end

  def generate_to_csv
    @products = Spree::Product.all
    col_names =  Spree::Product.column_names
    CSV.generate do |csv|
      csv << col_names
      @products.each do |product|
        csv << product.attributes.values_at(*col_names)
      end
    end
  end

  def create
    logger.warn "Current User #{try_spree_current_user.id}"
    @product_import = ProductImport.create(product_imports_params) #params[:product_import]

    @im_pro = ImportProducts::ImportJob.new(@product_import, try_spree_current_user)
 #s   @im_pro1 = ImportProducts::ImportJob.perform

   # Delayed::Job.enqueue ImportProducts::ImportJob.new(@product_import, try_spree_current_user)
    flash[:notice] = t('product_import_processing')
    redirect_to admin_product_imports_path
  end

  private

  def product_imports_params
    params.require(:product_import).permit(:data_file, :sku, :name, :master_price, :cost_price, :width, :height, :weight, :depth, :image_main, :image_2, :image_3, :image_4, :description, :category)
  end

end
