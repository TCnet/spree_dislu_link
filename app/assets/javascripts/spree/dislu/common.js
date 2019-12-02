

jQuery(document).ready(function ($) {
  
 /* TOGGLE */
    function dislu_dropdown() {
        $(document).on('click', '.header-control .close', function () {
            $(this).closest('.nozari-dropdown').removeClass('open');
        });
        $(document).on('click', function (event) {
            var _target = $(event.target).closest('.nozari-dropdown');
            var _allparent = $('.nozari-dropdown');

            if (_target.length > 0) {
                _allparent.not(_target).removeClass('open');
                if (
                    $(event.target).is('[data-nozari="nozari-dropdown"]') ||
                    $(event.target).closest('[data-nozari="nozari-dropdown"]').length > 0
                ) {
                    _target.toggleClass('open');
                    return false;
                }
            } else {
                $('.nozari-dropdown').removeClass('open');
            }
        });
    }

     // =====================slick============================
    function dislu_init_carousel() {
        $('.owl-slick').not('.slick-initialized').each(function () {
            var _this = $(this),
                _responsive = _this.data('responsive'),
                _config = [];

            if ($('body').hasClass('rtl')) {
                _config.rtl = true;
            }
            if (_this.hasClass('slick-vertical')) {
                _config.prevArrow = '<span class="pe-7s-angle-up"></span>';
                _config.nextArrow = '<span class="pe-7s-angle-down"></span>';
            } else {
                _config.prevArrow = '<span class="fa fa-angle-left"></span>';
                _config.nextArrow = '<span class="fa fa-angle-right"></span>';
            }
            _config.responsive = _responsive;
            _config.cssEase = 'linear';

            _this.slick(_config);
            _this.on('afterChange', function (event, slick, direction) {
                _this.find('.slick-active:first').addClass('first-slick');
                _this.find('.slick-active:last').addClass('last-slick');
            });
            _this.on('beforeChange', function (event, slick, currentSlide) {
                _this.find('.slick-slide').removeClass('last-slick');
                _this.find('.slick-slide').removeClass('first-slick');
            });
            if (_this.hasClass('slick-vertical')) {
                equal_elems();
                setTimeout(function () {
                    _this.slick('setPosition');
                }, 0);
            }
            _this.find('.slick-active:first').addClass('first-slick');
            _this.find('.slick-active:last').addClass('last-slick');
        });
    }
    // =====================slick end ============================

     /* ---------------------------------------------
     TAB EFFECT
     --------------------------------------------- */
    function dislu_tab_fade_effect() {
        // effect click
        $(document).on('click', '.nozari-tabs .tab-link a', function () {
            var tab_id = $(this).attr('href');
            var tab_animated = $(this).data('animate');

            tab_animated = ( tab_animated == undefined || tab_animated == "" ) ? '' : tab_animated;
            if (tab_animated == "") {
                return false;
            }

            $(tab_id).find('.product-list-owl .owl-item.active, .product-list-grid .product-item').each(function (i) {

                var t = $(this);
                var style = $(this).attr("style");
                style = ( style == undefined ) ? '' : style;
                var delay = i * 400;
                t.attr("style", style +
                    ";-webkit-animation-delay:" + delay + "ms;"
                    + "-moz-animation-delay:" + delay + "ms;"
                    + "-o-animation-delay:" + delay + "ms;"
                    + "animation-delay:" + delay + "ms;"
                ).addClass(tab_animated + ' animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                    t.removeClass(tab_animated + ' animated');
                    t.attr("style", style);
                });
            })
        })
    }

  //-----------------------dislu_tab_fade_effect end------------//
   




  dislu_dropdown();
  dislu_init_carousel();
  //nozari_details_thumd_zoom();
  //dislu_tab_fade_effect();

  
 
});