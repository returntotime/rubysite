$ ->
  Spree.handleTooglingTaxonomyFeatured()

Spree.handleTooglingTaxonomyFeatured = () ->
  $(".toggle-taxonomy-featured").on "click", ->
    taxonomy_id = $(this).data('id')
    $.ajax
#      dataType: 'script'
      method: 'POST'
      url: Spree.pathFor("admin/taxonomies/#{taxonomy_id}/toggle_featured")