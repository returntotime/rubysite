$(document).ready(function(){
    //---------------------------------------------------
    //========== PROCESSING CLICKING ON SLIDER
    //---------------------------------------------------
    $(document).on('click', 'li.slider-item', function(){
        var href = $(this).data('href');
        if(href.substring(href,4).toLowerCase() == 'http' || href.substring(href,5).toLowerCase() == 'https'){
            window.open(href,'_blank');
        }else{
            window.location = href;
        }
    });
    //-----------------------------------------------------------
    //========= PROCESSING FOR CLICKING ON X CART HEADER---------
    $(document).on('click','.del-line-item', function(e){
        if(confirm('Are you sure?')){
            showLoading();
            var line_item = $(this).data('item');
            var form = $("#update-cart-custom");
            form.append($("<input>", { type:'hidden', name:'order[line_items_attributes][0][quantity]', value: 0}));
            form.append($("<input>", { type:'hidden', name:'order[line_items_attributes][0][id]', value: line_item}));
            var postData = form.serialize();
            $.post('/cart', postData).done(function(){
                window.location = window.location.href;
                hideLoading();
            })
            .error(function(){
                alert('There is an error while processing')
            });
        }
        e.preventDefault();
    });

});