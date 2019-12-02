module Spree
  module Admin
    class DisluSlidersController < ResourceController

      
      
      


      def create
        if permitted_resource_params[:image] && Spree.version.to_f >= 3.6
          @dislu_slider.build_image(attachment: permitted_resource_params.delete(:image))
        end
        super
      end

      def update
        if permitted_resource_params[:image] && Spree.version.to_f >= 3.6
          @dislu_slider.create_image(attachment: permitted_resource_params.delete(:image))
        end
        super
      end


    end
  end
end