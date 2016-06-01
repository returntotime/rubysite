class AddActiveTeamSectionToSpreePages < ActiveRecord::Migration
  def change
    add_column :spree_pages, :active_our_team_section, :boolean, :default => false
  end
end
