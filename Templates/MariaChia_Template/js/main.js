/*-----------------------------------------------------------------------------------*/
/*      SEBIAN MAIN JS FILE
/*-----------------------------------------------------------------------------------*/
$(document).ready(function($) {

    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER DETAIL PRODUCT  =====
    /*-----------------------------------------------------------------------------------*/

    if ($('.slider-for').html() != undefined && $('.slider-nav').html() != undefined) {
        $('.slider-for').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            fade: true,
            asNavFor: '.slider-nav'
        });
        $('.slider-nav').slick({
            slidesToShow: 5,
            slidesToScroll: 1,
            asNavFor: '.slider-for',
            dots: false,
            arrows: true,
            focusOnSelect: true,
            prevArrow: '<button type="button" class="slick-prev"><i class="fa fa-chevron-circle-left"></i></button>',
            nextArrow: '<button type="button" class="slick-next"><i class="fa fa-chevron-circle-right"></i></button>',
            responsive: [{
                breakpoint: 1024,
                settings: {
                    slidesToShow: 5,
                    slidesToScroll: 5,
                }
            }, {
                breakpoint: 600,
                settings: {
                    slidesToShow: 4,
                }
            }, {
                breakpoint: 480,
                settings: {
                    slidesToShow: 2,
                }
            }]
        });
    }

    /*-----------------------------------------------------------------------------------*/
    // ======  FIX NAV  =====
    /*-----------------------------------------------------------------------------------*/
    var windowWidth = $(window).width();
    // fix-navright
    $('#fix-nav').affix({
        offset: {
            top: $('header').height()
        }
    });

    $('.search-panel .dropdown-menu').find('a').click(function(e) {
        e.preventDefault();
        var param = $(this).attr("href").replace("#", "");
        var concept = $(this).text();
        $('.search-panel span#search_concept').text(concept);
        $('.input-group #search_param').val(param);
    });
    /*-----------------------------------------------------------------------------------*/
    // ======  TOGGLE BUTTON  =====
    /*-----------------------------------------------------------------------------------*/

    // // button menu
    $('.navbar-toggle').on('click', function() {
        $(this).toggleClass('close-mt');
    });

    // // button navbar card
    // // button navbar search
    var resetAll = function() {
        $('.mt-open').removeClass('open');
    };
    var mticon = $('.mt-icon');
    mticon.click(function(e) {
        var drop = $(this).next();
        if (drop.hasClass('open')) {
            drop.removeClass('open');
        } else {
            resetAll();
            drop.addClass('open');
            var overlayE2 = $('#mtover');
            overlayE2.addClass('show');
        }
        e.stopPropagation();
    });
    // overlay
    $('body').append('<div id="mtover"></div>');
    $('#mtover').on('click', function() {
        mticon.trigger('click');
        resetAll();
        var overlayE2 = $('#mtover');
        overlayE2.removeClass('show');
    });


    /*-----------------------------------------------------------------------------------*/
    // ======  MENU RESPONSIVE  =====
    /*-----------------------------------------------------------------------------------*/

    var sideslider = $('[data-toggle=collapse-side]');
    var sel = sideslider.attr('data-target');
    sideslider.click(function(event) {
        $(sel).toggleClass('in');
        var overlayEl = $('#overlayMenu');
        overlayEl.toggleClass('show');
    });
    // overlay
    $('body').append('<div id="overlayMenu"></div>');
    $('#overlayMenu').on('click', function() {
        sideslider.trigger('click');
    });

    /*-----------------------------------------------------------------------------------*/
    // ======  SUB MENU  =====
    /*-----------------------------------------------------------------------------------*/

    $('.parent-nav').click(function() {
        var submenu = $(this).next();
        submenu.addClass('open');
    });

    $('.sub-menu-back').click(function() {
        var submenu = $(this).parent();
        submenu.removeClass('open');
    })
    "use strict"

    /*-----------------------------------------------------------------------------------*/
    /*  LOADER
    /*-----------------------------------------------------------------------------------*/
    $(window).load(function() {
        $("#loader").delay(500).fadeOut("slow");
    });


    /*-----------------------------------------------------------------------------------*/
    /*  ANIMATION
    /*-----------------------------------------------------------------------------------*/

    var wow = new WOW({
        boxClass: 'animate', // animated element css class (default is wow)
        animateClass: 'animated', // animation css class (default is animated)
        offset: 100, // distance to the element when triggering the animation (default is 0)
        mobile: false // trigger animations on mobile devices (true is default)
    });
    wow.init();

    /*-----------------------------------------------------------------------------------*/
    /*  PRODUCTS SLIDER
    /*-----------------------------------------------------------------------------------*/
    $(".product-slides").owlCarousel({
        items: 1,
        autoplay: false,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: true,
        animateOut: 'fadeOut'
    });

    /*-----------------------------------------------------------------------------------*/
    /*  ABOUT CLIENT SLIDER
    /*-----------------------------------------------------------------------------------*/

    $(".clients-about-slider").owlCarousel({
        autoplay: false,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: true,
        margin: 30,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            1200: {
                items: 3,
                nav: false
            }
        }
    });

    /*-----------------------------------------------------------------------------------*/
    /*  PRODUCTS SLIDER
    /*-----------------------------------------------------------------------------------*/

    $(".testi-slides").owlCarousel({
        items: 1,
        autoplay: true,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: true,
        animateOut: 'fadeOut'
    });

    /*-----------------------------------------------------------------------------------*/
    /*  ABOUT CLIENT SLIDER
    /*-----------------------------------------------------------------------------------*/

    $(".new-col-slide").owlCarousel({
        autoplay: false,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: false,
        margin: 30,
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            1200: {
                items: 3,
            }
        }
    });

    /*-----------------------------------------------------------------------------------*/
    /*      FEATURE SLIDER
    /*-----------------------------------------------------------------------------------*/
    $(".fur-slide").owlCarousel({
        autoplay: true,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: false,
        margin: 0,
        responsive: {
            0: {
                items: 1
            },
            1000: {
                items: 2,
            }
        }
    });

    /*-----------------------------------------------------------------------------------*/
    /*      CLIENTS LOGO SLIDE
    /*-----------------------------------------------------------------------------------*/
    $(".client-slide").owlCarousel({
        autoplay: true,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: false,
        loop: true,
        margin: 30,
        animateOut: 'fadeOut',
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            800: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    /*-----------------------------------------------------------------------------------*/
    /*      BANNER ITEMS SLIDER
    /*-----------------------------------------------------------------------------------*/
    $(".bnr-items-slider").owlCarousel({
        autoplay: true,
        autoplayHoverPause: true,
        singleItem: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        lazyLoad: true,
        nav: false,
        loop: true,
        margin: 0,
        animateOut: 'fadeOut',
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            800: {
                items: 2
            },
            1350: {
                items: 3
            },
            1600: {
                items: 4
            }
        }
    });

    /*-----------------------------------------------------------------------------------*/
    /*    POPUP VIDEO
    /*-----------------------------------------------------------------------------------*/
    $('.popup-vedio').magnificPopup({
        type: 'inline',
        fixedContentPos: false,
        fixedBgPos: true,
        overflowY: 'auto',
        closeBtnInside: true,
        preloader: true,
        midClick: true,
        removalDelay: 300,
        mainClass: 'my-mfp-slide-bottom'
    });
    $('.gallery-pop').magnificPopup({
        delegate: 'a',
        type: 'image',
        tLoading: 'Loading image #%curr%...',
        mainClass: 'mfp-img-mobile',
        gallery: {
            enabled: true,
            navigateByImgClick: true,
            preload: [0, 1] // Will preload 0 - before current, and 1 after the current image
        },
        image: {
            tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
            titleSrc: function(item) {
                return item.el.attr('title') + '';
            }
        }
    });
    /*-----------------------------------------------------------------------------------*/
    /*  SLIDER REVOLUTION
    /*-----------------------------------------------------------------------------------*/
    jQuery('.tp-banner').show().revolution({
        dottedOverlay: "none",
        delay: 10000,
        startwidth: 1170,
        startheight: 700,
        navigationType: "bullet",
        navigationArrows: "solo",
        navigationStyle: "preview4",
        parallax: "mouse",
        parallaxBgFreeze: "on",
        parallaxLevels: [7, 4, 3, 2, 5, 4, 3, 2, 1, 0],
        keyboardNavigation: "on",
        shadow: 0,
        fullWidth: "on",
        fullScreen: "on",
        shuffle: "off",
        autoHeight: "off",
        forceFullWidth: "off",
        fullScreenOffsetContainer: ""
    });

    /*-----------------------------------------------------------------------------------*/
    /*  SLIDER REVOLUTION
    /*-----------------------------------------------------------------------------------*/

    jQuery('.tp-banner-fix').show().revolution({
        dottedOverlay: "none",
        delay: 10000,
        startwidth: 1170,
        startheight: 700,
        navigationType: "bullet",
        navigationArrows: "solo",
        navigationStyle: "preview4",
        parallax: "mouse",
        parallaxBgFreeze: "on",
        parallaxLevels: [7, 4, 3, 2, 5, 4, 3, 2, 1, 0],
        keyboardNavigation: "on",
        fullWidth: "off",
        fullScreen: "off"
    });

    /*-----------------------------------------------------------------------------------*/
    /*  SLIDER REVOLUTION
    /*-----------------------------------------------------------------------------------*/

    jQuery('.tp-banner-box').show().revolution({
        dottedOverlay: "none",
        delay: 10000,
        startwidth: 1170,
        startheight: 780,
        navigationType: "bullet",
        navigationArrows: "solo",
        navigationStyle: "preview4",
        parallax: "mouse",
        parallaxBgFreeze: "on",
        parallaxLevels: [7, 4, 3, 2, 5, 4, 3, 2, 1, 0],
        keyboardNavigation: "on",
        fullWidth: "on",
        fullScreen: "off"
    });

    /*-----------------------------------------------------------------------------------*/
    /*      Parallax
    /*-----------------------------------------------------------------------------------*/

    $('.images-slider').flexslider({
        animation: "fade",
        controlNav: "thumbnails"
    });

    /*-----------------------------------------------------------------------------------*/
    /*  Go TO TOP
    /*-----------------------------------------------------------------------------------*/

    $(window).scroll(function() {
        if ($(this).scrollTop() > 500) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });
    // scroll body to 0px on click
    $('#back-to-top').click(function() {
        $('#back-to-top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 500);
        return false;
    });

});
