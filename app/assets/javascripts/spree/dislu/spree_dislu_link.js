// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'


//= require spree/frontend/coupon_manager

Spree.ready(function ($) {
  var formUpdateCart = $('form#update-cart')
  if (formUpdateCart.length) {
    $('form#update-cart a.delete').show().one('click', function () {
      $(this).parents('.line-item').first().find('input.line_item_quantity').val(0)
      $(this).parents('form').first().submit()
      return false
    })
  }
  
})
