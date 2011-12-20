class AddPivotalCredentials < ActiveRecord::Migration
  def up
	add_column :projects, :pivotal_user, :string
	add_column :projects, :pivotal_pass, :string
	add_column :projects, :pivotal_token, :string
  end

  def down
  end
end
