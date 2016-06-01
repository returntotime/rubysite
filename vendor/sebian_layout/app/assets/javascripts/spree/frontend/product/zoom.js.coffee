$(document).ready ->
  # Zoom
  setTimeout ->
    $('.zoom0').elevateZoom(
      scrollZoom: true
      zoomWindowWidth: $(".zoom0").width()
      zoomWindowHeight: $(".zoom0").height()
      zoomWindowOffetx: 10,
      borderSize: 3
    )
  , 200

#  $('.zoom0').elevateZoom()

  $(document).on 'afterChange','.slider-for', (event, slick, currentSlide, nextSlide) ->
    $('.zoomContainer').remove()
    $('.zoom' + currentSlide).elevateZoom(
      scrollZoom: true
      zoomWindowWidth: $('.zoom' + currentSlide).width()
      zoomWindowHeight: $('.zoom' + currentSlide).height()
      zoomWindowOffetx: 10,
      borderSize: 3
    )

  # Fancybox
  $('.fancybox-thumb').fancybox
    prevEffect: 'none'
    nextEffect: 'none'
    helpers:
      title: type: 'outside'
      thumbs:
        width: 50
        height: 50
