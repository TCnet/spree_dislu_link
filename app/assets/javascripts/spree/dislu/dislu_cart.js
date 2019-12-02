
Spree.ready(function ($) {

  Spree.dislu_fetch_cart = function () {
    return $.ajax({
      url: Spree.pathFor('dislu_cart_link')
    }).done(function (data) {
      return $('#dislu-link-to-cart').html(data)
    })
  }
  
})
