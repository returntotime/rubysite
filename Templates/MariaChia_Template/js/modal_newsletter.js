$(document).ready(function($) {
    /*-----------------------------------------------------------------------------------*/
    // ======  POPUP  =====
    /*-----------------------------------------------------------------------------------*/

    if ($('.subscribe-me').html() != undefined) {
        $(".subscribe-me").subscribeBetter({
            trigger: "atendpage",
            animation: "fade", //Change animation :flyInLeft, flyInRight, flyInUp, flyInDown
            delay: 0,
            showOnce: true,
            autoClose: false,
            scrollableModal: false
        });
    }

});
