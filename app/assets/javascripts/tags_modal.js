
//Tags modal
$(document).ready(function() {
    var add_tag_buttons = $(".add_tag")
    
    add_tag_buttons.each(function(index, add_tag_button){
        var button = $(add_tag_button)
        var uid = button.attr("attr-uid")
        var form_body = $(".tags_fields[attr-uid='"+uid+"']").first()
        var my_tags = $(".my_tags[attr-uid='"+uid+"']").first()
        
        button.click(function(e){
            e.preventDefault()
            add_tag(form_body, button, my_tags)
            return false
        })
    })
    
    function add_tag(form_body, tag, my_tags) {
        var tag_field = tag.clone()
        tag_field.append("<input type='hidden' name='tag_titles[]' id='tag_titles' value='"+tag_field.attr("attr-title")+"'>")
        form_body.append(tag_field)
        
        tag_field.click(function(e){
            e.preventDefault()
            tag.removeClass('invisible')
            $(this).remove()
            return false
        })
        
        tag.addClass('invisible')
    }
});