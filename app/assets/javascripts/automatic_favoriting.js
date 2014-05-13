$(document).ready(function(){
  $(".toggle-automatic-favoriting").bootstrapSwitch();

  $(".toggle-automatic-favoriting").on('switchChange.bootstrapSwitch', function(event, state) {
    var originalState = !state;

    $.ajax({
      type: "PUT",
      url: "/users/toggle_automatic_favoriting.json",
      data: {state: state}
    }).success(function(data){
      setAutomaticFavoritingState(data.state);
    }).error(function(data){
      setAutomaticFavoritingState(originalState);
    })
  });
});

function setAutomaticFavoritingState(enabled) {
  $('input[name="my-checkbox"]').bootstrapSwitch('state', enabled, true);
}
