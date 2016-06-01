#require '/home/aswathi/.rvm/gems/ruby-2.1.5/gems/delayed_job-4.1.1/lib/delayed_job.rb'
module ImportProducts
  class ImportJob
    attr_accessor :product_import_id
    attr_accessor :user_id

    def initialize(product_import_record, user)
      self.product_import_id = product_import_record.id
      self.user_id = user.id
      Rails.logger.info "User id in initializer #{user.id}"
      perform
    end

    def perform
      begin
        Rails.logger.info "Inside perform"
        product_import = ProductImport.find(self.product_import_id)
        results = product_import.import_data!
 #       Spree::UserMailer.product_import_results(Spree::User.find(self.user_id)).deliver
      rescue Exception => exp
 #       Spree::UserMailer.product_import_results(Spree::User.find(self.user_id), exp.message).deliver
      end
    end
  end
end

