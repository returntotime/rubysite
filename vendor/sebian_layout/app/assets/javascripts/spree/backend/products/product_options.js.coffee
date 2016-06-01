$ ->
  Spree.handleTooglingProductOption()

Spree.handleTooglingProductOption = () ->
  $(".product-option").on "click", ->
    field = $(this).attr "name"
    product = $(this).data "id"
    $.post Spree.pathFor("admin/products/#{product}/update_options"), {field: field, val: this.checked}




