Spree.ready ($) ->
  Spree.onAddress = () ->
    if ($ '#checkout_form_address').is('*')
#      ($ '#checkout_form_address').validate()

      getCountryId = (region) ->
        $('#' + region + 'country select').val()

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

      ($ '#bcountry select').change ->
        Spree.updateState 'b'

      ($ '#scountry select').change ->
        Spree.updateState 's'

      Spree.updateState 'b'

      order_use_billing = ($ 'input#order_use_billing')
      order_use_billing.change ->
        update_shipping_form_state order_use_billing

      update_shipping_form_state = (order_use_billing) ->
        if order_use_billing.is(':checked')
          ($ '#shipping .inner').hide()
          ($ '#shipping .inner input, #shipping .inner select').prop 'disabled', true
        else
          ($ '#shipping .inner').show()
          ($ '#shipping .inner input, #shipping .inner select').prop 'disabled', false
          Spree.updateState('s')

      update_shipping_form_state order_use_billing

      Spree.validateAddressFields = () ->
        $('#checkout_form_address').validate
          rules:
            'order[email]':
              'required': true
              'maxlength': 255
              'email': true
            'order[bill_address_attributes][firstname]':
              'required': true
              'maxlength': 255
            'order[bill_address_attributes][lastname]':
              'required': true
              'maxlength': 255
            'order[bill_address_attributes][address1]':
              'required': true
              'maxlength': 255
            'order[bill_address_attributes][city]':
              'required': true
              'maxlength': 255
            'order[bill_address_attributes][phone]':
              'required': true
              'maxlength': 20
              'digits': true
            'order[bill_address_attributes][zipcode]':
              'required': true
              'maxlength': 7
#            'order[bill_address_attributes][state_id]':
#              'required': true
#            'order[bill_address_attributes][country_id]':
#              'required': true
            'order[ship_address_attributes][firstname]':
              'required': true
              'maxlength': 255
            'order[ship_address_attributes][lastname]':
              'required': true
              'maxlength': 255
            'order[ship_address_attributes][address1]':
              'required': true
              'maxlength': 255
            'order[ship_address_attributes][city]':
              'required': true
              'maxlength': 255
            'order[ship_address_attributes][phone]':
              'required': true
              'maxlength': 20
              'digits': true
            'order[ship_address_attributes][zipcode]':
              'required': true
              'maxlength': 7
#            'order[ship_address_attributes][state_id]':
#              'required': true
#            'order[ship_address_attributes][country_id]':
#              'required': true
          errorElement: 'div'
#          errorPlacement: (error, element) ->
#            if $(element).is('select')
#              element.next().after error
#              # special placement for select elements
#            else
#              error.insertAfter element
#            # default placement for everything else

      Spree.validateAddressFields()

#      $("#checkout_form_address select").on "change", ->
#        Spree.submitCheckoutFormAddress()


#      window.address_update_timeout = null
      $("#checkout_form_address input[type='text']").on "change", ->
#        clearTimeout(window.address_update_timeout)
        Spree.submitCheckoutFormAddress()

#      $("#checkout_form_address input[type='text']").on "keyup", ->
#        clearTimeout(window.address_update_timeout)
#        window.address_update_timeout = setTimeout(Spree.submitCheckoutFormAddress(), 3000)
#
#      $("#checkout_form_address input[type='tel']").on "keyup", ->
#        clearTimeout(window.address_update_timeout)
#        window.address_update_timeout = setTimeout(Spree.submitCheckoutFormAddress(), 3000)

      $("#order_bill_address_attributes_state_id").on "change", ->
#        clearTimeout(window.address_update_timeout)
        Spree.submitCheckoutFormAddress()

      Spree.submitCheckoutFormAddress = () ->
        if $("#checkout_form_address").valid()
          showLoading()
          $("#checkout_form_address").submit()

      if $("#delivery-methods input[type='radio']").length <= 0
        Spree.submitCheckoutFormAddress()

  Spree.onAddress()
