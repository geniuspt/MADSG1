class CreateProjs < ActiveRecord::Migration
  def change
    create_table :projs do |t|
      t.string :name

      t.timestamps
    end
  end
end
