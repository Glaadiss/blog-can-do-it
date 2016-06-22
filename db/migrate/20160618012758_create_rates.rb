class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :mark
      t.references :user, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true
      t.references :blog, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
