# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.read-more').click ->
  $(this).parents('.content').hide()
  $(this).parents('.content').siblings('.content').show()
  false

$('nav ul li a').click ->
  $('#menu-button').click()
  false

$('#map .search-box button').click ->
  $('#map .search-box input').val()

calcRoute = (autocomplete, directionsService, directionsDisplay, service, defaultRoute) ->
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

    directionsService.route(request, (result, status) ->
      directionsDisplay.setDirections(result) if (status == google.maps.DirectionsStatus.OK)
    )
  else
    input = $('#user-start-point').val()

    if input
      textSearchRequest = {
        query: input
      }

      service.textSearch(textSearchRequest, (results, status) ->
        if status == google.maps.places.PlacesServiceStatus.OK && results.length > 0 && results[0].geometry
          request = {
            origin: results[0].geometry.location,
            destination: party,
            waypoints: [{ location: church, stopover: true }],
            travelMode: google.maps.TravelMode.DRIVING
          }

          directionsService.route(request, (result, status) ->
            directionsDisplay.setDirections(result) if (status == google.maps.DirectionsStatus.OK)
          )
        else
          directionsDisplay.setDirections(defaultRoute)
      )
    else
      directionsDisplay.setDirections(defaultRoute)

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

  service = new google.maps.places.PlacesService(map);

  church = 'Estrada Caetano Monteiro, 104 - Badu, RJ, 24320-570'
  party = 'Estrada Pacheco de Carvalho, 160 - Maceio, RJ'

  defaultRequest = {
    origin: church,
    destination: party,
    travelMode: google.maps.TravelMode.DRIVING
  }

  defaultRoute = null

  directionsService.route(defaultRequest, (result, status) ->
    if (status == google.maps.DirectionsStatus.OK)
      defaultRoute = result
      directionsDisplay.setDirections(result)
  )

  google.maps.event.addListener(autocomplete, 'place_changed', () ->
    calcRoute(autocomplete, directionsService, directionsDisplay, service, defaultRoute)
  )

  $('#map .search-box button').click ->
    calcRoute(autocomplete, directionsService, directionsDisplay, service, defaultRoute)
