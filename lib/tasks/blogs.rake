namespace :blogs do
  task :add_blogs_role_for_all_users => :environment do
    bloger_role = Spree::Role.find_by(:name=>'blogger')
    if bloger_role.present?
      bloger_role.user_ids = Spree::User.all.collect(&:id)
    end
  end
end