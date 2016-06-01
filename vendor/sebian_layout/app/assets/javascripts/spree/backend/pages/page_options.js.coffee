$ ->
  Spree.handleTooglingPageOption()

Spree.handleTooglingPageOption = () ->
  $(".chkpage").on "click", ->
    field = $(this).attr "name"
    page = $(this).data "id"
    $.post Spree.pathFor("admin/pages/#{page}/update_options"), {field: field, val: this.checked}

