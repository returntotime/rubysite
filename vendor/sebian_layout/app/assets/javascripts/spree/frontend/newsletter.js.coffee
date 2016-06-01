Spree.newsletter_popup = (trigger, animation, delay) ->
  if $('.subscribe-me').html() != undefined
    $('.subscribe-me').subscribeBetter
      trigger: trigger
      animation: animation
      delay: delay
      showOnce: true
      autoClose: false
      scrollableModal: false

