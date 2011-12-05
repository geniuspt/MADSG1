class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.integer :id_pivotal
      t.string :role
      t.string :email
      t.string :initials

      t.timestamps
    end
  end
end
