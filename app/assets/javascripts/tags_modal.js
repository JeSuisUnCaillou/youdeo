
//Tags modal
$(document).ready(function() {
    
    var tag_model = $(".tag_model").first()
    var add_tag_buttons = $(".add_tag")
    
    add_tag_buttons.each(function(index, add_tag_button){
        add_tag_button_event($(add_tag_button))
    })
    
    var add_new_tag_buttons = $(".add_new_tag")
    
    add_new_tag_buttons.each(function(index, add_new_tag_button){
        add_new_tag_button_event($(add_new_tag_button))
    })
    
    
    // BELOW : TO ADD A NEW TAG
    
    function add_new_tag_button_event(button){
        var uid = button.attr("attr-uid")
        var form_body = $(".tags_fields[attr-uid='"+uid+"']").first()
        var title_field = $(".title_field[attr-uid='"+uid+"']").first()
        
        button.click(function(e){
            e.preventDefault()
            var title = title_field.val() // Get the field's value
            if(title){
                var new_tag = build_tag(title, 0, null)
                title_field.val("") // Empty the field
                form_body.append(new_tag)
            }
            return false
        })
    }
    
    // BELOW : TO ADD AN EXISTING TAG
    
    function add_tag_button_event(button){
        var uid = button.attr("attr-uid")
        var form_body = $(".tags_fields[attr-uid='"+uid+"']").first()
        var my_tags = $(".my_tags[attr-uid='"+uid+"']").first()
        
        button.click(function(e){
            e.preventDefault()
            add_tag(form_body, button, my_tags)
            return false
        })
    }
    
    function add_tag(form_body, tag, my_tags) {
        var tag_field = tag.clone()
        tag.append("<input type='hidden' name='tag_titles[]' id='tag_titles' value='"+tag_field.attr("attr-title")+"'>")
        
        form_body.append(tag_field)
        
        tag_field.click(function(e){
            e.preventDefault()
            tag.removeClass('invisible')
            $(this).remove()
            return false
        })
        
        tag.addClass('invisible')
    }
    
    // BELOW : BUILD A TAG FROM ITS INFORMATIONS
    
    // If channel_uid.present?, this is a tag that can restore an existing one
    function build_tag(title, channels_count, channel_uid){
        var tag = tag_model.clone()
        var true_title
        
        if(channels_count > 0){
            true_title = title + "(" + channels_count + ")"
        } else {
            true_title = title
        }
        
        tag.append("<input type='hidden' name='tag_titles[]' id='tag_titles' value='"+title+"'>")
        tag.removeClass('tag_model')
        tag.find('div.tag_text').text(true_title)
        tag.attr('attr-title', title)
        tag.attr('attr-uid', channel_uid)
        
        tag.click(function(e){
            e.preventDefault()
            $(this).remove()
            return false
        })
        
        return tag
    }
    
});