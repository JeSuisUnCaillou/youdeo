
//Video player
$(document).ready(function() {
    var video_player = $('#video_player')
    var video_cards = $('.video_card')
    
    video_cards.each(function(index, card){
        var video_card = $(card)
        var uid = get_video_uid(video_card)
        video_card.click(function(e){
            e.preventDefault()
            reset_video_player(uid)
            return false
        })
    })
    
    //Extracts the video uid from the html id of the video_card
    function get_video_uid(video_card){
        return video_card.attr('attr-uid')
    }
    
    function reset_video_player(video_uid){
        video_player.attr('src', "https://www.youtube.com/embed/" + video_uid)
    }
});
