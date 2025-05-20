class CreateToyPostRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :toy_post_relations do |t|
      t.integer :toy_id
      t.integer :post_id

      t.timestamps
    end

    #ぬいぐるみと投稿の組み合わせにunique付与
    add_index :toy_post_relations, [:toy_id, :post_id], unique: true
  end
end
