$(document).ready(function() {
    // Zoom
    setTimeout(function() {
        return $('.zoom0').elevateZoom({
            scrollZoom: true,
            zoomWindowWidth: $(".zoom0").width(),
            zoomWindowHeight: $(".zoom0").height(),
            zoomWindowOffetx: 10
        });
    }, 200);

    $('.slider-for').on('afterChange', function(event, slick, currentSlide, nextSlide) {
        $('.zoomContainer').remove();
        return setTimeout(function() {
            return $('.zoom' + currentSlide).elevateZoom({
                scrollZoom: true,
                zoomWindowWidth: $('.zoom' + currentSlide).width(),
                zoomWindowHeight: $('.zoom' + currentSlide).height(),
                zoomWindowOffetx: 10
            });
        }, 200);
    });

    // Fancybox
    $(".fancybox-thumb").fancybox({
        prevEffect: 'none',
        nextEffect: 'none',
        helpers: {
            title: {
                type: 'outside'
            },
            thumbs: {
                width: 50,
                height: 50
            }
        }
    });

});
