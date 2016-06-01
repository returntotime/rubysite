Spree.ready ($) ->
#  Spree.onDelivery()
  Spree.handleDeliveryChange()

  Spree.handlePlaceOrder()

Spree.onDelivery = () ->
  if ($ '#checkout_form_delivery').is('*')
    if $("#delivery-methods input[type='radio']").length > 0
      $("#checkout_form_delivery").submit()

Spree.handleDeliveryChange = () ->
  if ($ '#checkout_form_delivery').is('*')
    $("#checkout_form_delivery input").on "change", ->
      showLoading()
      $('#checkout_form_delivery').submit()