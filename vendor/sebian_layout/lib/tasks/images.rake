namespace :images do
  task :adjust_color => :environment do
    Spree::Image.all.each do |image|
      image.attachment.reprocess!
    end
  end
end