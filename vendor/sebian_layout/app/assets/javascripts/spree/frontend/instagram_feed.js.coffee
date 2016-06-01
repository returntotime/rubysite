Spree.hanldeInstagramImages = (clientId) ->
  feed = new Instafeed(
    get: 'popular'
#    tagName: 'awesome'
    limit: '36'
    sort_by: 'most-recent'
    clientId: clientId
    template: ''
    success: (data)->
      count = data.data.length
      i = 0
      html = ''
      while i < count
        if html == ''
          html = '<div class=\"item\">'
        html += '<a target=\'_blank\' href=\'' + data.data[i].link + '\'><img class="owl-lazy" data-src=\'' + data.data[i].images.low_resolution.url + '\' /></a>'
        if (i + 1)%2 == 0
          html = html + "</div>"
          $('#instafeed').append html
          html = ''
        i++

      $('.instagram-slide').owlCarousel
        loop: true
        margin: 10
        nav: false
        lazyLoad : true
        animateIn: 'fadeIn'
        responsive:
          0: items: 1
          480: items: 2
          600: items: 4
          800: items: 4
          1200: items: 6
  )
  feed.run()


Spree.hanldeInstagramImagesFooter = (clientId) ->
  feed = new Instafeed(
    get: 'popular'
    limit: '6'
    sort_by: 'most-recent'
    clientId: clientId
    template: '<li><a href="{{link}}"><img src="{{image}}" /></a></li>'
  )
  feed.run()





