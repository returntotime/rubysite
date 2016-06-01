Spree.ready ($) ->
  if ($ 'form#update-cart').is('*')
    ($ 'form#update-cart a.delete').unbind('click').on 'click',(e) ->
      e.preventDefault()
      if confirm "Are you sure?"
        ($ this).parents('.line-item').first().find('input.line_item_quantity').val 0
        line_item_id = $(this).data("line_item_id")
        $(".line-item-mobile-#{line_item_id}").find('input.line_item_quantity').val 0
        $(".line-item-lap-#{line_item_id}").find('input.line_item_quantity').val 0
        ($ this).parents('form').first().submit()
      else
        false

    getCountryId = (region) ->
      $('#' + region + 'country select').val()

    Spree.Checkout = {}
    Spree.updateState = (region) ->
      countryId = getCountryId(region)
      if countryId?
        unless Spree.Checkout[countryId]?
          $.get Spree.routes.states_search, {country_id: countryId}, (data) ->
            Spree.Checkout[countryId] =
              states: data.states
              states_required: data.states_required
            Spree.fillStates(Spree.Checkout[countryId], region)
        else
          Spree.fillStates(Spree.Checkout[countryId], region)

    Spree.fillStates = (data, region) ->
      statesRequired = data.states_required
      states = data.states

      statePara = ($ '#' + region + 'state')
      stateSelect = statePara.find('select')
      stateInput = statePara.find('input')
      stateSpanRequired = statePara.find('[id$="state-required"]')
      if states.length > 0
        selected = parseInt stateSelect.val()
        stateSelect.html ''
        statesWithBlank = [{ name: '', id: ''}].concat(states)
        $.each statesWithBlank, (idx, state) ->
          opt = ($ document.createElement('option')).attr('value', state.id).html(state.name)
          opt.prop 'selected', true if selected is state.id
          stateSelect.append opt

        stateSelect.prop('disabled', false).show()
        stateInput.hide().prop 'disabled', true
        statePara.show()
        stateSpanRequired.show()
        stateSelect.addClass('required') if statesRequired
        stateSelect.removeClass('hidden')
        stateInput.removeClass('required')
      else
        stateSelect.hide().prop 'disabled', true
        stateInput.show()
        if statesRequired
          stateSpanRequired.show()
          stateInput.addClass('required')
        else
          stateInput.val ''
          stateSpanRequired.hide()
          stateInput.removeClass('required')
        statePara.toggle(!!statesRequired)
        stateInput.prop('disabled', !statesRequired)
        stateInput.removeClass('hidden')
        stateSelect.removeClass('required')
      stateSelect.selectpicker('refresh')


    ($ '#scountry select').change ->
      Spree.updateState 's'

    Spree.updateState 's'

  ($ 'form#update-cart').submit ->
    ($ 'form#update-cart #update-button').attr('disabled', true)

Spree.fetch_cart = ->
  $.ajax
    url: Spree.pathFor("cart_link"),
    success: (data) ->
      $('#link-to-cart').html data
