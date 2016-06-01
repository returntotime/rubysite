namespace :menu_bars do
  task :add_data => :environment do
    menu_bar = Spree::MenuBar.find_or_create_by(name: "main_menu")

    Spree::Taxonomy.all.limit(10).each do |taxonomy|
      url = "/t/#{taxonomy.root.permalink}"
      name = taxonomy.root.name
      menu_bar.menus.find_or_create_by(url: url, link_text: name)
    end
  end
end