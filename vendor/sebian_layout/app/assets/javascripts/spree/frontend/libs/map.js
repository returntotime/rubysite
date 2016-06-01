/*==========  Map  ==========*/
$(document).ready(function(){
  function initialize_map() {
    if ($('#map').length) {
      var map_address = $('#map-address').val();
      if(map_address!='' && typeof map_address == 'string'){
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': map_address }, function (results, status) {
          var latitude = -37.814199;
          var longitude = 144.961560;
          if (status == google.maps.GeocoderStatus.OK) {
            latitude = results[0].geometry.location.lat();
            longitude = results[0].geometry.location.lng();
          }
          var myLatLng = new google.maps.LatLng(latitude, longitude);
          var mapOptions = {
            zoom: 17,
            center: myLatLng,
            scrollwheel: false,
            panControl: false,
            zoomControl: true,
            scaleControl: false,
            mapTypeControl: false,
            streetViewControl: false
          };
          map = new google.maps.Map(document.getElementById('map'), mapOptions);
          var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            tittle: 'Envato',
            icon: '/map-locator.png'
          });
        });
      }
    } else {
      return false;
    }
  }
  initialize_map();
});