class ChangeCollationForTagNames < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.adapter_name == "Mysql2"
      execute("ALTER TABLE tags MODIFY name varchar(255) CHARACTER SET utf8 COLLATE utf8_bin;")
    end
  end
end