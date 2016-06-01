// = require spree/frontend/reviews/jquery.rating
// = require spree/frontend/reviews/review

// Navigating to a page with ratings via TurboLinks shows the radio buttons
$(document).on('page:load', function () {
  $('input[type=radio].star').rating();
});
