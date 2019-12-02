class AddDisluSlidersStores < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_dislu_sliders_stores, id: false do |t|
      t.integer :store_id
      t.integer :dislu_slider_id
      t.timestamps null: false
    end

    add_index :spree_dislu_sliders_stores, :store_id
    add_index :spree_dislu_sliders_stores, :dislu_slider_id
  end
end


