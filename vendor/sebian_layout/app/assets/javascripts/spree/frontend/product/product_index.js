$(document).ready(function(){
    $(document).on('change','#product_filter select',function(){
        $(this).parents('form').first().submit();
    });
});