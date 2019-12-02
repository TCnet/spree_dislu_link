class CreateSpreeDisluSlider < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_dislu_sliders do |t|
     t.string :name
     t.string :remark
     t.string :slug
     t.text :note
     t.integer :position, default: 1, null: false
     t.boolean :show_in_home, default: false, null: false
     t.boolean :show_in_product, default: false, null: false
     t.boolean :show_in_page, default: false, null: false
     t.boolean :show_in_sidebar, default: false, null: false
     t.string  :foreign_link
     t.boolean :visible, default: false, null: false


     t.timestamps
    end
    add_index :spree_dislu_sliders, :name, unique: true
  end
end
