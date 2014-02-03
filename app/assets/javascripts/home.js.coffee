# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.show-menu').click ->
  $('body').toggleClass('menu-open')
  false

$('.read-more').click ->
  $(this).parents('.content').hide()
  $(this).parents('.content').siblings('.content').show()
  false

$(document).ready ->
  google.maps.visualRefresh = true
  mapOptions = {
    center: new google.maps.LatLng(0, 0),
    zoom: 12
  };

  map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions)

  directionsService = new google.maps.DirectionsService();

  start = 'Estrada Caetano Monteiro, 104 - Badu, RJ, 24320-570'
  end = 'Estrada Pacheco de Carvalho, 160 - Maceio, RJ'

  request = {
    origin: start,
    destination: end,
    travelMode: google.maps.TravelMode.DRIVING
  }

  directionsDisplay = new google.maps.DirectionsRenderer()
  directionsDisplay.setMap(map)

  directionsService.route(request, (result, status) ->
    directionsDisplay.setDirections(result) if (status == google.maps.DirectionsStatus.OK)
  )
