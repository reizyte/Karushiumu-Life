class CreateRecipeComments < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_comments do |t|
      t.integer :customer_id, null: false
      t.integer :recipe_id, null: false
      t.text :comment

      t.timestamps
    end
  end
end
