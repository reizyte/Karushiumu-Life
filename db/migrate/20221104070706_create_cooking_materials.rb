class CreateCookingMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :cooking_materials do |t|
      t.integer :recipe_id, null: false
      t.string :material_name, null: false
      t.string :quantity, null: false

      t.timestamps
    end
  end
end
