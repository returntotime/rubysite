$(document).ready(function(){
   $("#review-form").validate({
       rules:{
           'review[name]' : {
               "required":true,
               "maxlength":255
           },
           'review[email]' : {
               "required":true,
               "maxlength":255,
               "email": true
           },
           'review[review]' : {
               "required":true
           }
       }
   });
});