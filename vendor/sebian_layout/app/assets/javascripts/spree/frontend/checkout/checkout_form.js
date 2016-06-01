//$(document).ready(function(){
//
//    var addressForm = '#checkout_form_address';
//    var deliveryForm = 'form#checkout_form_delivery';
//    var paymentForm = 'form#checkout_form_payment';
//
//    //-------=PROCESS FOR ADDRESS FORM CHANGING--------
//    $(document).on('change',addressForm + ' input[type=text], '+ addressForm +' select', function(e){
//        postAddressForm();
//    });
//
//    function postAddressForm(){
//        if($(addressForm).valid()){
//            postForm($(addressForm));
//            getAddressForm();
//            getOrderSummary();
//            getShipmentForm();
//        }
//    }
//
//
//    //-------=PROCESS FOR DELIVERY FORM CHANGING--------
//    $(document).on('change', deliveryForm + ' input', function(){
//        if($(deliveryForm).valid()){
//            postForm($(deliveryForm));
//        }
//    });
//
//    //-------=PROCESS FOR PAYMENT FORM CHANGING--------
//    $(document).on('click', paymentForm + ' input[type=radio]', function(){
//        $(paymentForm).validate();
//        if($(paymentForm).valid()){
//            postForm($(paymentForm));
//        }
//    });
//
//    $(document).on('click', '#place-order', function(){
//        //---- POST ADDRESS FORM
//
//
//    });
//
//    //------POST FORM---
//    var error_function = function(){
//        alert('There is an error while processing');
//        //window.location = window.href;
//    };
//
//
//    function postForm(form){
//        if(typeof form != undefined){
//            showLoading();
//            $.post(form.attr('action'), form.serialize())
//                .done(function(){ hideLoading(); })
//                .error(error_function);
//        }
//    }
//
//    //------GET ORDER SUMMARY---
//    function getOrderSummary(){
//        showLoading();
//        $.get('/checkout/get_order_summary').done(function(res){
//            $('#order_summary_wrapper').html(res.html_content);
//            hideLoading();
//        }).error(error_function);
//    }
//    //------GET ORDER SUMMARY---
//    function getShipmentForm(){
//        showLoading();
//        $.get('/checkout/get_shipment_form').done(function(res){
//            $('#shipment_form_wrapper').html(res.html_content);
//            var numMethod = $(deliveryForm).find('input[type=radio]');
//            //if(numMethod.length > 0){
//            //    $(deliveryForm + ' input').trigger('change');
//            //}else{
//            //    alert('There is no shipping method in this zone, Please select another one.');
//            //}
//            hideLoading();
//        }).error(error_function);
//    }
//
//    //----GET ADDRESS FORM----
//    function getAddressForm(){
//        showLoading();
//        $.get('/checkout/get_address_form').done(function(res){
//            if(res && typeof res == 'object'){
//                if($.trim(res.bill_address) != ''){
//                    if($(addressForm).find('input#order_bill_address_attributes_id').length > 0){
//                        $(addressForm).find('input#order_bill_address_attributes_id').remove();
//                    }
//                    $(addressForm).append('<input type="hidden" value="'+ res.bill_address +'" name="order[bill_address_attributes][id]" id="order_bill_address_attributes_id">');
//                }
//
//                if($.trim(res.ship_address) != ''){
//                    if($(addressForm).find('input#order_ship_address_attributes_id').length > 0){
//                        $(addressForm).find('input#order_ship_address_attributes_id').remove();
//                    }
//                    $(addressForm).append('<input type="hidden" value="'+ res.ship_address +'" name="order[ship_address_attributes][id]" id="order_ship_address_attributes_id">');
//                }
//
//                if($.trim(res.email) != ''){
//                    if($(addressForm).find('input#order_email').length == 0){
//                        $(addressForm).append('<input type="hidden" value="'+ res.email +'" name="order[email]" id="order_email">');
//                    }
//                }
//            }
//            hideLoading();
//        }).error(error_function);
//    }
//});