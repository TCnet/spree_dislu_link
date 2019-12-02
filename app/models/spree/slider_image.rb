module Spree
  class SliderImage < Asset
    include Spree::Image::Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
          url: polymorphic_path(attachment.variant(resize: size), only_path: true),
          width: width,
          height: height
        }
        
      end
    end

    def self.styles
            @styles ||= {
              mini: '48x48>',
              small: '100x100>',
              product: '240x240>',
              large: '600x600>',
              big: '1400x1400>',
              banner: '1170x500>'
            }
          end
  end
end