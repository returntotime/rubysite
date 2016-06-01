$(document).ready(function(){
    $(document).on('click', '.sidebar-menu-item',function () {
        var expanded = $(this).find('a').first().attr('aria-expanded');
        if(typeof expanded == 'string'){
            var href = $(this).find('a').first().attr('href');
            if(expanded == 'true'){
                var expanded_menu = getCookie('expanded_menu');
                var expanded_menu_item = (expanded_menu == "") ? [] :expanded_menu.split('|');
                if(expanded_menu_item.indexOf(href) < 0){
                    expanded_menu_item.push(href);
                }
                setCookie("expanded_menu", expanded_menu_item.join('|'), 10);
            }else if(expanded == 'false'){
                var expanded_menu = getCookie('expanded_menu');
                var expanded_menu_item = (expanded_menu == "") ? [] :expanded_menu.split('|');
                if(expanded_menu_item.indexOf(href) != -1){
                    if(typeof expanded_menu_item == 'object'){
                        $.each(expanded_menu_item, function(k,v){
                            if(v == href){
                                expanded_menu_item.splice(k,1);
                            }
                        });
                    }
                }
                setCookie("expanded_menu", expanded_menu_item.join('|'), 10);
            }
        }
    });
});

//--------BEGIN GET AND SET COOKIE
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    }
    return "";
}
//--------END GET AND SET COOKIE