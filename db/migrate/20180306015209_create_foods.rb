class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :calorie
      t.string :image_url
      t.string :comment

      t.timestamps
    end
  end
end
