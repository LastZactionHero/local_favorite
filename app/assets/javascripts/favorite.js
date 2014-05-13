$(document).ready(function(){
  $(".favorite").click(function(){
    var tweetId = $(this).attr('data-tweet-id');
    $(this).removeClass("btn-primary");
    $(this).removeClass("favorite");
    $(this).addClass("btn-warning");
    $(this).append("d");

    $.post("/favorites.json", {tweet_id: tweetId}).success(function(){
    })
    return false;
  });
});
