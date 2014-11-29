$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

function blacklistUser(username) {
  $.post("/blacklist_users/", {username: username})
  alert("This user has been blacklisted")
}