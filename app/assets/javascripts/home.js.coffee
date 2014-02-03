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

calcRoute = (autocomplete, directionsService, directionsDisplay) ->
  church = 'Estrada Caetano Monteiro, 104 - Badu, RJ, 24320-570'
  party = 'Estrada Pacheco de Carvalho, 160 - Maceio, RJ'
  userPlace = autocomplete.getPlace()

  if userPlace && userPlace.geometry
    userStart = userPlace.geometry.location
    request = {
      origin: userStart,
      destination: party,
      waypoints: [{ location: church, stopover: true }],
      travelMode: google.maps.TravelMode.DRIVING
    }

  else
    $('#user-start-point').val('')
    request = {
      origin: church,
      destination: party,
      travelMode: google.maps.TravelMode.DRIVING
    }

  directionsService.route(request, (result, status) ->
    directionsDisplay.setDirections(result) if (status == google.maps.DirectionsStatus.OK)
  )

$(document).ready ->
  google.maps.visualRefresh = true
  mapOptions = {
    center: new google.maps.LatLng(0, 0),
    zoom: 12,
    scrollwheel: false,
  };

  map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions)

  rendererOptions = {
    draggable: true
  };

  directionsService = new google.maps.DirectionsService();

  directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions)
  directionsDisplay.setMap(map)

  autocomplete = new google.maps.places.Autocomplete(document.getElementById('user-start-point'))

  calcRoute(autocomplete, directionsService, directionsDisplay)

  google.maps.event.addListener(autocomplete, 'place_changed', () ->
    calcRoute(autocomplete, directionsService, directionsDisplay)
  )
