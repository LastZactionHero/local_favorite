$(document).ready(function(){
  $(".favorite").click(function(){
    var tweetId = $(this).attr('data-tweet-id');
    var favorited = $(this).attr('data-favorited');

    button = $(this);

    if(favorited == 'true') {
        button.removeClass("btn-warning");
        button.addClass("btn-primary");
        button.attr("data-favorited", false);
        $.post("/favorites/unfavorite.json", {tweet_id: tweetId}).success(function(){
        });
    } else {
        $.post("/favorites.json", {tweet_id: tweetId}).done(function(){
          button.removeClass("btn-primary");
          button.addClass("btn-warning");
          button.attr("data-favorited", true);
        }).error(function(){
          alert("You have favorited the maxium number of tweets today for this plan.");
        });
    }

    return false;
  });
});
