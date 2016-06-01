$(document).ready(function(){
    //--------------------------------------------------------------
    //----------PROCESS CLICKING ON FEATURED CHECKBOX---------------
    //--------------------------------------------------------------
    $(document).on('click','input.toggle-blog-category', function(){
        var category = $(this).data('id');
        var val = this.checked ? 1 : 0;
        $.post('/admin/blog_categories/update_featured', {category_id:category, val: val})
            .done(function(res){
                if(res != "" && res.num_featured){
                    if(parseInt(res.num_featured) >= 3 ){
                        alert('You have already selected 3 featured categories');
                        $('input.toggle-blog-category[data-id='+category+']').prop("checked", false);
                    }
                }
            });
    });
});