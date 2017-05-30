 function initMap() {
        var listings =   <%= raw @alllistings %>

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: <%=@zoom%>,
          center: {lat: <%=@lat%>, lng: <%=@lng%>}
        });

        var markers = [];
        var infowindows = [];
        
        for (var i = 0; i < listings.length; i++){
          markers[i] = new google.maps.Marker({
            animation: google.maps.Animation.DROP,
            position: {lat: listings[i].latitude, lng: listings[i].longitude },
            map: map,
            url: "/listings/sale/" + listings[i].id,
            id: i
          })

          infowindows[i] = new google.maps.InfoWindow({
            content: listings[i].address + " " + listings[i].street + " " + listings[i].city + " " + listings[i].state + " " + listings[i].zip 
            + "<img src='<%= asset_path( "templogo.png" ) %>' />"
          });

          google.maps.event.addListener(markers[i], 'click', function () {
              infowindows[this.id].open(map, markers[this.id]);
          })

          }

        // This loops over all the listings from the query and displays markers for each.


        var geocoder = new google.maps.Geocoder();

        document.getElementById('submit').addEventListener('click', function() {
          geocodeAddress(geocoder, map);
        });
      }

      function geocodeAddress(geocoder, resultsMap) {
        var address = document.getElementById('address').value;
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
            resultsMap.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }