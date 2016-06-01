require 'spree_core'
require 'import_products_hooks'
#require 'delayed_job'
#require 'delayed_job_active_record'
#require '/home/aswathi/.rvm/gems/ruby-2.1.5/gems/delayed_job-4.1.1/lib/delayed_job.rb'

module ImportProducts
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      UserMailer.send(:include, ImportProducts::UserMailerExt)

    end

    config.to_prepare &method(:activate).to_proc
  end
end
