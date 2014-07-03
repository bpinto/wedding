# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.read-more').click ->
  $(this).parents('.content').hide()
  $(this).parents('.content').siblings('.content').show()
  false

$('nav ul li a.nav-link').click ->
  $('#menu-button').click()
  false

$('#map .search-box button').click ->
  $('#map .search-box input').val()

$(document).ready ->
  google.maps.visualRefresh = true

  Gmaps.initializeMap('map_canvas')

  Gmaps.initializeAutocomplete('user-start-point')

  Gmaps.initializePlacesService()

  Gmaps.directionsService.route(Gmaps.defaultRequest, (result, status) ->
    if (status == google.maps.DirectionsStatus.OK)
      Gmaps.defaultRoute = result
      Gmaps.directionsDisplay.setDirections(result)
      leg = result.routes[0].legs[0]
      Gmaps.makeMarker(leg.start_location, Gmaps.locations.church.icon, Gmaps.locations.church.title)
      Gmaps.makeMarker(leg.end_location, Gmaps.locations.party.icon, Gmaps.locations.party.title)
  )

  google.maps.event.addListener(Gmaps.autocomplete, 'place_changed', () ->
    Gmaps.calcRoute()
  )

  $('#map .search-box button').click ->
    Gmaps.calcRoute()
