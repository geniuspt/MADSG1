class CreateUserStories < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.string :token
      t.integer :id_pivotal
      t.string :url
      t.string :api_url
      t.string :story_type
      t.string :current_state
      t.text :description
      t.string :name
      t.string :requested_by
      t.string :created_at_pivotal
      t.string :labels
      t.string :owned_by
      t.string :accepted_at

      t.timestamps
    end
  end
end
