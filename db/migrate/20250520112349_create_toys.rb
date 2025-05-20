class CreateToys < ActiveRecord::Migration[6.1]
  def change
    create_table :toys do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :introduction

      t.timestamps
    end
  end
end
