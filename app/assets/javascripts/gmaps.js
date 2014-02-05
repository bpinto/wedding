var Gmaps = {

  mapOptions: {
    center: new google.maps.LatLng(0, 0),
    zoom: 12,
    scrollwheel: false,
  },

  rendererOptions: {
    draggable: true,
    suppressMarkers: true,
  },

  map: null,
  directionsDisplay: null,
  directionsService: null,
  autocomplete: null,
  placesService: null,

  homeMarker: null,

  locations: {
    church: {
      address: 'Estrada Caetano Monteiro, 104 - Badu, RJ, 24320-570',
      icon: '/assets/church_marker.png',
      title: 'Capela São Sebastião'
    },
    party: {
      address: 'Estrada Pacheco de Carvalho, 160 - Maceio, RJ',
      icon: '/assets/party_marker.png',
      title: 'Casa de Festas Solarium'
    },
    home: {
      icon: '/assets/home_marker.png',
      title: 'Sua Casa'
    }
  },

  defaultRequest: {
    origin: 'Estrada Caetano Monteiro, 104 - Badu, RJ, 24320-570',
    destination: 'Estrada Pacheco de Carvalho, 160 - Maceio, RJ',
    travelMode: google.maps.TravelMode.DRIVING
  },

  defaultRoute: null,

  initializeMap: function(id){
    Gmaps.map = new google.maps.Map(document.getElementById(id), Gmaps.mapOptions)

    Gmaps.directionsService = new google.maps.DirectionsService()

    Gmaps.directionsDisplay = new google.maps.DirectionsRenderer(Gmaps.rendererOptions)
    Gmaps.directionsDisplay.setMap(Gmaps.map)
  },

  initializeAutocomplete: function(id){
    Gmaps.autocomplete = new google.maps.places.Autocomplete(document.getElementById(id))
  },

  initializePlacesService: function(){
    Gmaps.placesService = new google.maps.places.PlacesService(Gmaps.map)
  },

  calcRoute: function(){
    userPlace = Gmaps.autocomplete.getPlace()

    if(Gmaps.homeMarker){
      Gmaps.homeMarker.setMap(null)
    }

    if(userPlace && userPlace.geometry){
      userStart = userPlace.geometry.location
      request = {
        origin: userStart,
        destination: Gmaps.locations.party.address,
        waypoints: [{ location: Gmaps.locations.church.address, stopover: true }],
        travelMode: google.maps.TravelMode.DRIVING
      }

      Gmaps.directionsService.route(request, function(result, status){
        if(status == google.maps.DirectionsStatus.OK){
          Gmaps.directionsDisplay.setDirections(result)
          leg = result.routes[0].legs[0]
          Gmaps.homeMarker = Gmaps.makeMarker(leg.start_location, Gmaps.locations.home.icon, Gmaps.locations.home.title)
        }
      })
    }else{
      input = $('#user-start-point').val()

      if(input){
        textSearchRequest = {
          query: input
        }

        Gmaps.placesService.textSearch(textSearchRequest, function(results, status){
          if(status == google.maps.places.PlacesServiceStatus.OK && results.length > 0 && results[0].geometry){
            request = {
              origin: results[0].geometry.location,
              destination: Gmaps.locations.party.address,
              waypoints: [{ location: Gmaps.locations.church.address, stopover: true }],
              travelMode: google.maps.TravelMode.DRIVING
            }

            Gmaps.directionsService.route(request, function(result, status){
              if(status == google.maps.DirectionsStatus.OK){
                Gmaps.directionsDisplay.setDirections(result)
                leg = result.routes[0].legs[0]
                Gmaps.homeMarker = Gmaps.makeMarker(leg.start_location, Gmaps.locations.home.icon, Gmaps.locations.home.title)
              }
            })
          }else
            Gmaps.directionsDisplay.setDirections(Gmaps.defaultRoute)
        })
      }else{
        Gmaps.directionsDisplay.setDirections(Gmaps.defaultRoute)
      }
    }
  },

  makeMarker: function(position, icon, title){
    return new google.maps.Marker({
      position: position,
      map: Gmaps.map,
      icon: icon,
      title: title
    })
  },
}
