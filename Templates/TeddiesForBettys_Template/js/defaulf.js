$(document).ready(function() {

    /*-----------------------------------------------------------------------------------*/
    // ====== LOADER  =====
    /*-----------------------------------------------------------------------------------*/

    $(window).load(function() {
        $("#loader").delay(500).fadeOut("slow");
    });

    /*-----------------------------------------------------------------------------------*/
    // ======  ANIMATION  =====
    /*-----------------------------------------------------------------------------------*/

    var wow = new WOW({
        boxClass: 'animate', // animated element css class (default is wow)
        animateClass: 'animated', // animation css class (default is animated)
        offset: 0, // distance to the element when triggering the animation (default is 0)
        mobile: false, // trigger animations on mobile devices (default is true)
        live: true, // act on asynchronously loaded content (default is true)
        callback: function(box) {},
        scrollContainer: null // optional scroll container selector, otherwise use window
    });
    wow.init();

    /*-----------------------------------------------------------------------------------*/
    // ====== LIGHTBOX  =====
    /*-----------------------------------------------------------------------------------*/

    lightbox.option({
        'resizeDuration': 50,
        'wrapAround': true,
        // ' alwaysShowNavOnTouchDevices': true,
        // 'disableScrolling': true,
        // 'fadeDuration': 1000,
    })

    /*-----------------------------------------------------------------------------------*/
    // ======  DROPDOWN TOP  =====
    /*-----------------------------------------------------------------------------------*/

    var resetAll = function() {
        $('.dropdown-mt-menu').removeClass('open');
    };
    $('.dropdown-mt p').click(function() {
        var drop = $(this).next();
        if (drop.hasClass('open')) {
            drop.removeClass('open');
        } else {
            resetAll();
            drop.addClass('open');
        }
    });

    /*-----------------------------------------------------------------------------------*/
    // ======  TOGGLE BUTTON  =====
    /*-----------------------------------------------------------------------------------*/

    // button menu
    $('.navbar-toggle').on('click', function() {
        $(this).toggleClass('close-mt');
    });
    // button navbar card
    $('.nav-card').on('click', function() {
        $('.nav-card-detail').toggleClass('open');
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

    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER INDEX  =====
    /*-----------------------------------------------------------------------------------*/

    $("#slider-index").owlCarousel({
        navigation: true, // Show next and prev buttons
        slideSpeed: 300,
        paginationSpeed: 400,
        singleItem: true
    });

    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER ROW 1  =====
    /*-----------------------------------------------------------------------------------*/

    var owl = $("#slider-row-01");
    owl.owlCarousel({
        itemsCustom: [
            [0, 1],
            [600, 2],
            [1000, 3]
        ],
    });
    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER ROW 5 TESTIMONIALS  =====
    /*-----------------------------------------------------------------------------------*/

    var owl = $("#slider-testimonials");
    owl.owlCarousel({
        itemsCustom: [
            [0, 1],
            [600, 1],
            [1000, 1]
        ],
    });
    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER ROW 10 OUR CLIENTS  =====
    /*-----------------------------------------------------------------------------------*/

    var owl = $("#slider-ourclients");
    owl.owlCarousel({
        itemsCustom: [
            [0, 2],
            [480, 4],
            [1200, 5]
        ],
    });

    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER ROW 5 TESTIMONIALS  =====
    /*-----------------------------------------------------------------------------------*/

    var user_content = $("#user_content");
    var user_avata = $("#user_avata");

    user_content.owlCarousel({
        singleItem: true,
        slideSpeed: 1000,
        navigation: false,
        pagination: true,
        afterAction: syncPosition,
        responsiveRefreshRate: 200,
    });

    user_avata.owlCarousel({
        pagination: false,
        responsiveRefreshRate: 100,
        itemsCustom: [
            [0, 2],
            [480, 3],
        ],
        afterInit: function(el) {
            el.find(".owl-item").eq(0).addClass("synced");
        }
    });

    function syncPosition(el) {
        var current = this.currentItem;
        $("#user_avata")
            .find(".owl-item")
            .removeClass("synced")
            .eq(current)
            .addClass("synced")
        if ($("#user_avata").data("owlCarousel") !== undefined) {
            center(current)
        }
    }

    $("#user_avata").on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).data("owlItem");
        user_content.trigger("owl.goTo", number);
    });

    function center(number) {
        var user_avatavisible = user_avata.data("owlCarousel").owl.visibleItems;
        var num = number;
        var found = false;
        for (var i in user_avatavisible) {
            if (num === user_avatavisible[i]) {
                var found = true;
            }
        }

        if (found === false) {
            if (num > user_avatavisible[user_avatavisible.length - 1]) {
                user_avata.trigger("owl.goTo", num - user_avatavisible.length + 2)
            } else {
                if (num - 1 === -1) {
                    num = 0;
                }
                user_avata.trigger("owl.goTo", num);
            }
        } else if (num === user_avatavisible[user_avatavisible.length - 1]) {
            user_avata.trigger("owl.goTo", user_avatavisible[1])
        } else if (num === user_avatavisible[0]) {
            user_avata.trigger("owl.goTo", num - 1)
        }

    }
});
