class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.references :user
      t.references :page
      t.text :body

      t.timestamps
    end
  end
end
