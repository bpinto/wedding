$(document).ready ->
  $("section#rsvp form .guests .row").hide();

  $("section#rsvp form select").change ->
    total_guests = $("section#rsvp form select").val()
    guests_inputs = $("section#rsvp form .guests .row")
    $(guests_inputs).hide()
    for i in [0..parseInt(total_guests)-2] by 1
      $(guests_inputs[i]).show()
