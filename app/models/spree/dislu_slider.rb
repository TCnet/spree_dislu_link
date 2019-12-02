module Spree
  class DisluSlider <  ActiveRecord::Base
    
    default_scope { order(position: :asc) }
    
    has_and_belongs_to_many :stores, join_table: 'spree_dislu_sliders_stores'
    
    with_options dependent: :destroy do
      if Spree.version.to_f >= 3.6
        has_one :image, as: :viewable, dependent: :destroy, class_name: 'Spree::SliderImage'
      end
    end
    

    validates :name, presence: true
    validates :slug,  presence: true, if: :not_using_foreign_link?
    

    scope :visible, -> { where(visible: true) }
    scope :home_sliders, -> { where(show_in_home: true).visible }
    scope :product_sliders, -> { where(show_in_product: true).visible }
    scope :page_sliders, -> { where(show_in_page: true).visible }
    scope :sidebar_sliders, -> { where(show_in_sidebar: true).visible }


   scope :by_store, ->(store) { joins(:stores).where('spree_dislu_sliders_stores.store_id = ?', store) }


   def link
    foreign_link.blank? ? slug : foreign_link
   end

  
     

  
    

    private
     def not_using_foreign_link?
        foreign_link.blank?
     end


  end
  
 end
