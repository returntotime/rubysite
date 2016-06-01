$(document).ready(function(){

    if($('select.options').length > 0) {
        handleOptionValueQuantityAndEmpty();
        variantChange();
    } else {
        getInitSlick();
    }
    $(document).on('change','.options',function(){
        handleOptionValueChanged($(this));
    });
    //-------------------SPREE IMAGE SLIDER----------------------
    /*-----------------------------------------------------------------------------------*/
    // ======  SLIDER DETAIL PRODUCT  =====
    /*-----------------------------------------------------------------------------------*/
    function getInitSlick() {
        if ($('.slider-for').html() != undefined && $('.slider-nav').html() != undefined) {
            $('.slider-for').slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                fade: true,
                asNavFor: '.slider-nav'
            });

            $('.slider-nav').slick({
                slidesToShow: 5,
                slidesToScroll: 1,
                asNavFor: '.slider-for',
                dots: false,
                arrows: true,
                focusOnSelect: true,
                prevArrow: '<button type="button" class="slick-prev"><i class="fa fa-chevron-circle-left"></i></button>',
                nextArrow: '<button type="button" class="slick-next"><i class="fa fa-chevron-circle-right"></i></button>',
                responsive: [{
                    breakpoint: 1024,
                    settings: {
                        slidesToShow: 5,
                        slidesToScroll: 5,
                    }
                }, {
                    breakpoint: 600,
                    settings: {
                        slidesToShow: 4,
                    }
                }, {
                    breakpoint: 480,
                    settings: {
                        slidesToShow: 2,
                    }
                }]
            });
        }
    }
    //------------------ON CLICK ON THUMBNAIL--------------------
    $(document).on('click','#product-thumbnails li.thumb-image a',function(e){
        e.preventDefault();
        var img = $(this).find('img').first();
        var src = $(this).attr('href');
        $(this).parents('#product-thumbnails').first().find('img.active').removeClass('active');
        img.addClass('active');
        $('#main-image').find('img').first().attr('src',src);
    });

    function variantChange(){
        var checkedRadio = $("#product-variants").find('input[type=radio][name=variant_id]:checked');
        $('span.price').html(checkedRadio.data('price'));
        filterThumbnail(checkedRadio.val());
    }

    function filterThumbnail(variant_id){

        //-------------------------------------------
        //---CHECKING PRODUCT IMAGES WHETHER TO SHOW
        //-------------------------------------------
        var showProductImage = false;
        var null_counter = 0;
        $('select.options').each(function(){
            if($.trim($(this).val()) == "" || $(this).val() == null){
                null_counter++;
            }
        });
        if($('select.options').length == null_counter){
            showProductImage = true;
        }

        var htmlSlide = '<div class="slider slider-for">';
        //------------------------------------------------
        //---------STRING FOR VARIANT AND PRODUCTS MAIN IMAGE
        //------------------------------------------------
        var product_key = 0;
        if(showProductImage == true){
            $.each(window.product_images, function (key, val) {
                htmlSlide += '<div>';
                htmlSlide += '<a class="fancybox-thumb" rel="fancybox-thumb" href="' + val.original_image + '" >';
                htmlSlide += '<img class="img-responsive zoom' + product_key + '" src="' + val.large_image + '" data-zoom-image="' + val.original_image + '">';
                htmlSlide += '</a>';
                htmlSlide += '</div>';
                product_key++;
            });
        }else{
            $.each(window.variant_images, function (key, val) {
                if (val.variant_id == variant_id) {
                    htmlSlide += '<div>';
                    htmlSlide += '<a class="fancybox-thumb" rel="fancybox-thumb" href="' + val.original_image + '" >';
                    htmlSlide += '<img class="img-responsive zoom' + product_key + '" src="' + val.large_image + '" data-zoom-image="' + val.original_image + '">';
                    htmlSlide += '</a>';
                    htmlSlide += '</div>';
                    product_key++;
                }
            });
        }
        //---------IF THERE IS NO IMAGE
        if(product_key == 0){
            htmlSlide += '<div>';
            htmlSlide += '<a class="fancybox-thumb" rel="fancybox-thumb" href="' + window.no_product_image.large_image + '" >';
            htmlSlide += '<img class="img-responsive zoom0" src="' + window.no_product_image.large_image + '" data-zoom-image="' + window.no_product_image.large_image + '">';
            htmlSlide += '</a>';
            htmlSlide += '</div>';
        }
        htmlSlide += '</div>';
        //------------------------------------------------
        //---------STRING FOR VARIANT AND PRODUCTS NAV----
        //------------------------------------------------
        htmlSlide += '<div class="slider slider-nav">';
        if(showProductImage == true) {
            $.each(window.product_images, function (key, val) {
                htmlSlide += '<div class="img-product-thumb">';
                htmlSlide += '<img class="img-responsive variant_thumb_' + val.variant_id + '" data-variant="' + val.variant_id + '" src="' + val.small_image + '">';
                htmlSlide += '</div>';
            });
        }else {
            $.each(window.variant_images, function (key, val) {
                if (val.variant_id == variant_id) {
                    htmlSlide += '<div class="img-product-thumb">';
                    htmlSlide += '<img class="img-responsive variant_thumb_' + val.variant_id + '" data-variant="' + val.variant_id + '" src="' + val.small_image + '">';
                    htmlSlide += '</div>';
                }
            });
        }
        htmlSlide += '</div>';
        $('.large-detail').html(htmlSlide);
        getInitSlick();

        var image_variant = $("img.variant_thumb_" + variant_id);
        if(image_variant.length > 0){
            var currentImg = $('.slider-nav .slick-current').find('img').first();
            if(currentImg.data('variant') != variant_id){
                var divItem = image_variant.parent('div.slick-slide').first();
                divItem.trigger('click');
            }
        }
        setTimeout(function() {
            return $('.zoom0').elevateZoom({
                scrollZoom: true,
                zoomWindowWidth: $(".zoom0").width(),
                zoomWindowHeight: $(".zoom0").height(),
                zoomWindowOffetx: 10,
                borderSize: 3
            });
        }, 200);
    }

    function handleOptionValueQuantityAndEmpty(){
        $(document).find("#option-types-error").html("");
        var selector = '';
        var loop_counter = 0;
        var options_name = "";
        $('select.options').each(function (index, element) {
            var option_name = $(this).find('option:selected').text();
            options_name += option_name;
            if (index < $('select.options').length - 1){
                options_name += " & ";
            }
            var selected_option_value = $(this).val();
            if($.trim(selected_option_value) == ""){selected_option_value = null}
            selector += '[data-'+ $(this).data('id') + '='+ selected_option_value +']';
            if($.trim(selected_option_value) != ''){
                loop_counter ++;
            }
        });

        var selected = $('#product-variants li' + selector);
        if(selected.length > 0){
            selected.find('input[type=radio][name=variant_id]').prop('checked',true);
            if (selected.find('input[type=radio][name=variant_id]').data("can_supply") == false){
                $(document).find("#option-types-error").html(options_name + ' - OUT OF STOCK');
                $("#add-to-cart-button, #quantity").hide();
            } else {
                $("#add-to-cart-button, #quantity").show();
            }
        }else{
            $("#add-to-cart-button, #quantity").hide();
        }
        //else{
        //    selected.find('input[type=radio]').prop('checked',true);
        //    if(loop_counter == $('select.options').length){
        //        $(document).find("#option-types-error").html(options_name + ' was not found, please choose again.');
        //        $("#add-to-cart-button, #quantity").hide();
        //        //$(this).val('').change();
        //    } else {
        //        $("#add-to-cart-button, #quantity").show();
        //    }
        //}
    }

    //-------------PROCESS FOR CHOOSE ANY OPTION DROPDOWN---------
    //------------------------------------------------------------

    handleOptionValueChanged($('select.options').first());
    function handleOptionValueChanged(currentOption){
        if($('select.options').length > 0){
            //---LIST OF VARIANTS
            var variants = [];
            $('input[name=variant_id]').each(function(){
                variants.push($(this).val());
            });

            var selected = {};
            var option_tmp = {};
            $('select.options').each(function(key, val){
                var position = $(this).data('position');
                if(parseInt(position) > parseInt(currentOption.data('position'))){
                    var current_option_type_id = $(this).data('id');
                    var params = {
                        'variants'              : variants,
                        'current_option_type'   :current_option_type_id
                    };
                    $.each(selected, function(k,v){
                        option_tmp['option_type_' + (position-1)] = k;
                        option_tmp['option_value_' + (position-1)] = v;
                        params = $.extend({}, params, option_tmp);
                    });

                    $.get('/products/get_options', params).done(function(data){
                        var option_text = '';
                        $.each(data.values, function(key, val){
                            option_text += '<option value="' + val.id + '">'+ val.presentation +'</option>';
                        });
                        $('#option_type_' + current_option_type_id).html(option_text);
                        $('#option_type_' + current_option_type_id).selectpicker('refresh');
                        handleOptionValueQuantityAndEmpty();
                        variantChange();
                    });
                }else{
                    handleOptionValueQuantityAndEmpty();
                    variantChange();
                }
                var tmpMerged = {};
                tmpMerged[$(this).data('id')] = $(this).val();
                selected = $.extend({}, tmpMerged, selected);
            });
        }
    }

    $(document).on('click', '#wishlist_submit', function(e){
        if($('#wishlist_form').length > 0){
            $('#wishlist_form').submit();
        }
    });
});

