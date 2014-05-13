$(document).ready(function(){
  $(".favorite").click(function(){
    var tweetId = $(this).attr('data-tweet-id');
    var favorited = $(this).attr('data-favorited');
    if(favorited == 'true') {
        $(this).removeClass("btn-warning");
        $(this).addClass("btn-primary");
        $(this).attr("data-favorited", false);
        $.post("/favorites/unfavorite.json", {tweet_id: tweetId}).success(function(){
        });
    } else {
        $(this).removeClass("btn-primary");
        $(this).addClass("btn-warning");
        $(this).attr("data-favorited", true);
        $.post("/favorites.json", {tweet_id: tweetId}).success(function(){
        })
    }

    return false;
  });
});
