require 'spree_core'
require 'spree_import_products/engine'
#require 'delayed_job_active_record'


module ImportProducts
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Spree::UserMailer.send(:include, ImportProducts::UserMailerExt)

    end

    config.to_prepare &method(:activate).to_proc
  end
end
