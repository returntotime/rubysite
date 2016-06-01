$(document).ready(function() {
    //-----EMPTY CART ON CLICKING EMPTY CART BUTTON
    $(document).on('click', '#btn_empty_cart', function (e) {
        e.preventDefault();
        if(confirm("Are you sure?")) {
            $("#fempty_cart").submit();
        }
    });
    //-----ADD ESTIMATE HIDDEN FIELD TO UPDATE CART FORM
    $(document).on('click','#btn_estimate_shipping',function(e){
        e.preventDefault()
        $("#update-cart").append('<input type="hidden" name="estimate_shipping" value="yes">');
        $("#update-cart").submit();
    });

});