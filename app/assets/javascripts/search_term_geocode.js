$(document).ready(function(){
  $("#search_term_location").on("input", null, null, function(){
    var location = $(this).val();
    geocodeLocation(location);
  });

  $(".past-location").click(function(){
    var locationId = $(this).attr('data-location-id');
    var locationName = $(this).attr('data-location-name');
    var radius = $(this).attr("data-location-radius");

    $("#search_term_location").val(locationName);
    $("#search_term_location_id").val(locationId);
    $("#search_term_radius").val(radius);

    return false;
  });
});

function geocodeLocation(location){
  $.get("/locations/geocode.json", {address: location}).done(
    function(data){
      if(data.latitude && data.longitude) {
          $(".found-location").removeClass('hidden');
          $("#latitude").html(data.latitude);
          $("#longitude").html(data.longitude);
          $("#search_term_location_id").val(null);
      } else {
        $(".found-location").hide();
      }
    }
  ).error(function(){
    $(".found-location").addClass('hidden')
  });
}
