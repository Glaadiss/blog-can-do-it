class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.attachment :avatar

      t.timestamps null: false
    end

    
  end
end
