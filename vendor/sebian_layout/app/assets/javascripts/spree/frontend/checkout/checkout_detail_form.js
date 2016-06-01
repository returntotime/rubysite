//$(document).ready(function(){
//    $(document).on('click','input#use_billing',function(e){
//        if($(this).is(':checked') == false){
//            $("#shipping_address_modal").modal();
//        }else{
//            fillBillingForm();
//        }
//    });
//    if($('#use_billing:checked').length < 1){
//        $("#shipping_address_modal").modal();
//    }
//    //--------PASSWORD FORM -----
//    $(document).on('click','#create_account',function(e){
//        if($(this).is(':checked') == true){
//            $('#password_form').first().modal();
//        }
//    });
//    $(document).on('hide.bs.modal','#password_form', function(e){
//        var password_val = $('#password_form').find('#order_user_password').val();
//        var password_confirmation_val = $('#password_form').find('#order_user_password_confirmation').val();
//        if($.trim(password_val)=='' || $.trim(password_confirmation_val)==''){
//            e.preventDefault();
//            alert('Please enter password and password-confirmation');
//            e.cancel();
//            return false;
//        }else if($.trim(password_val) != $.trim(password_confirmation_val)){
//            e.preventDefault();
//            alert('Please enter the same value again');
//            e.cancel();
//            return false;
//        }
//    });
//    //-------- FILL EMAIL TO USER FORM -----
//    $(document).on('keyup change','#order_email',function(e){
//        fillEmailToUserForm();
//    });
//    fillEmailToUserForm();
//    function fillEmailToUserForm(){
//        var email = $('#order_email').val();
//        $('#order_user_email').val(email);
//    }
//    //--------ACCEPT CONDITION-----
//    //acceptCondition();
//    $(document).on('click',"#accept-condition",function(e){
//        //acceptCondition();
//        postCheckoutForm();
//        if($(this).parents('.checkbox').find('div.error').length > 0 && $(this).is(':checked')){
//            $(this).parents('.checkbox').find('div.error').remove();
//        }
//    });
//
//    function acceptCondition(){
//        if($("#accept-condition").is(':checked') == false){
//            $("#place-order").attr('disabled','disabled');
//        }else{
//            $("#place-order").attr('disabled',false);
//        }
//    }
//    //--------------CHECKOUT FORM VALIDATION-------
//    $("#checkout_form").validate({
//        rules:{
//            //---------------------------BILLING ADDRESS-----------
//            'order[email]' : {
//                "required"  : true,
//                "maxlength" : 255,
//                "email"     : true
//            },
//            'order[bill_address_attributes][firstname]' : {
//                "required"  : true,
//                "maxlength" : 255
//            },
//            'order[bill_address_attributes][lastname]' : {
//                "required"  : true,
//                "maxlength" : 255
//            },
//            'order[bill_address_attributes][address1]': {
//                "required"  : true,
//                "maxlength" : 255
//            },
//            'order[bill_address_attributes][city]':{
//                "required"  : true,
//                "maxlength" : 255
//            },
//            'order[bill_address_attributes][phone]':{
//                "required"  : true,
//                "maxlength" : 20,
//                "digits": true
//            },
//            'order[bill_address_attributes][zipcode]':{
//                "required"  : true,
//                "maxlength" : 7
//            },
//            'order[bill_address_attributes][state_id]':{
//                "required"  : true
//            },
//            'order[bill_address_attributes][country_id]':{
//                "required"  : true
//            }
//        },
//        errorElement: "div"
//    });
//    //--------------FILL BILLING ADDRESS FORM-----------
//    var prefix_billing_form = 'order_bill_address_attributes';
//    var prefix_shiping_form = 'order_ship_address_attributes';
//    var bill_form = $('#fbill_address');
//    var ship_form = $('#fshiping_address');
//
//    $(document).on('change','#fbill_address input[type=text], #fbill_address select', function(e){
//        if($('#use_billing:checked').length > 0){
//            fillBillingForm();
//        }
//        postCheckoutForm();
//    });
//
//    function fillBillingForm(){
//        bill_form.find('input[type=text], select').each(function(){
//            var self_id = $(this).attr('id');
//            var target_id = prefix_shiping_form + self_id.substr(prefix_billing_form.length);
//            if($('#'+target_id).length > 0){
//                if(this.tagName == 'INPUT'){
//                    $('#'+target_id).val($('#'+self_id).val());
//                }else{
//                    $('#'+target_id).val($('#'+self_id).val()).change();
//                }
//            }
//        });
//    }
//    //---------------VALIDATE Expiration DATE----------
//    $(document).on('focusout','#card_expiry',function(){
//        var value = $(this).val().split('/');
//        if(value!=''){
//            var month = value[0];
//            if(parseInt(month) > 12 || parseInt(month) < 1){
//                alert('Please enter Expiration date correctly');
//                $(this).focus();
//            }
//        }
//    });
//
//    //--------------COUNTRY STATE CHANGED-----------------
//    $(document).on('change', '#checkout_form_payment input[type=radio]', function(){
//        postCheckoutForm();
//    });
//
//    $(document).on('change', '#shipping_method input', function(){
//        postCheckoutForm();
//    });
//
//    function postCheckoutForm(){
//        if($("#checkout_form").html() != undefined && $("#checkout_form").valid()){
//            var form = $('form#checkout_form');
//            var params = '';
//            if($('#fshipping_method input:checked').length == 0) {
//                if($('input[name=no_payment]').length == 0){
//                    form.append('<input type="hidden" name="no_payment" value="1">');
//                }
//            }else{
//                if($('input[name=no_payment]').length > 0){
//                    form.find('input[name=no_payment]').remove();
//                }
//            }
//            showLoading();
//            $.post(form.attr('action'),form.serialize()).done(function(res){
//                if(res){
//                    if(res.state && $.trim(res.state)!=''){
//                        $("form#checkout_form").attr('action','/checkout/update/'+res.state);
//                    }
//                    if(res.shipment_form && $.trim(res.shipment_form)){
//                        $('#fshipping_method').html(res.shipment_form);
//                        //$('#fshipping_method input:checked').focus();
//                    }
//                    hideLoading();
//                }
//            });
//        }
//    }
//    //-------CHECK IF FORM VALIDATED => POST FORM =========
//    postCheckoutForm();
//    $(document).on('submit', "#checkout_form", function(){
//        $( "#accept-condition" ).rules( "add", {
//            required: true,
//            messages: {
//                required: "Please accept term and condition."
//            }
//        });
//        if(!$(this).valid()){
//            return false;
//        }
//        return true;
//    });
//    //-----------------------------------------------------
//});