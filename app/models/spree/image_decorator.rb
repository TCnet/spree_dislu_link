
module SpreeDisluLink
  module Spree
    module ImageDecorator
      module ClassMethods
        def styles
          {
            mini:    '48x48>',
            small:   '100x100>',
            medium:  '300x300>',
            product: '400x400>',
            large:   '600x600>',
            big: '650x829>',
            xbig: '1000x1000>',
          }
        end
      end

      def self.prepended(base)
        base.singleton_class.prepend ClassMethods
      end
    end
  end
end

Spree::Image.prepend ::SpreeDisluLink::Spree::ImageDecorator