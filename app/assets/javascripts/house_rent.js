function initMap() {

    var url = window.location.pathname

    var split = url.split('/')

    var query = split[split.length-1]


var fullquery = function(){
    $.get(query +'.json', function(data){

        //make the map if there are results
        if(data.length > 0){
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 14,
                center: {lat: data[0].latitude, lng: data[0].longitude}
            });
        }

        else{ // make the map if there are no results
            var googleurl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + query + "&key=AIzaSyDEIuPwq4UmLFZ-zqDXmqP1NI54lJhXllY"

            $.get(googleurl, function(gdata){

                var maplatlong = gdata.results[0].geometry.location;

                var map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 12,
                    center: maplatlong
                });

            })
            }

        var markers = [];
        var infowindows = [];

        //loop to create several parts on map
        for (var i = 0; i < data.length; i++){

            //makes markers on map
            markers[i] = new google.maps.Marker({
                animation: google.maps.Animation.DROP,
                position: {lat: data[i].latitude, lng: data[i].longitude },
                map: map,
                url: "/listings/sale/" + data[i].id,
                id: i
            }) // close of marker creator

            //Markers have 2 types: with and without images

            //if statement for markers that have images
            if (data[i].rental_image){ 
                infowindows[i] = new google.maps.InfoWindow({
                    content: "<div class='infobox'>"
                    + "<a href='/listings/rent/" + data[i].id + "'><img src='" + data[i].rental_image.gallery[0].url + "' /></a><br>" 

                    + data[i].address + " " + data[i].street + " " + data[i].city + " " + data[i].state + " " + data[i].zip 
                    + "<br> Rent: $" + data[i].price + " per month"
                    + "<br><a href='/listings/rent/" + data[i].id + "'> More Info </a>"
                    + " | "
                    + "<form action='/listings/rent/" + data[i].id + "/favorite' method='POST'>"
                    + "<input type='hidden' name='authenticity_token' value='<%= form_authenticity_token %>'>"
                    +"<input type='submit' value='Add to Favorites'></form>"
                    + "</div>"
                });
            }
            
                //else statement for listings that don't have images
                else{
                    infowindows[i] = new google.maps.InfoWindow({
                    content: "<div class='infobox'>"
                    + data[i].address + " " + data[i].street + " " + data[i].city + " " + data[i].state + " " + data[i].zip 
                    + "<br> Rent: $" + data[i].price + " per month"
                    + "<br><a href='/listings/rent/" + data[i].id + "'> More Info </a>"
                    + " | "
                    + "<form action='/listings/rent/" + data[i].id + "/favorite' method='POST'>"
                    + "<input type='hidden' name='authenticity_token' value='<%= form_authenticity_token %>'>"
                    +"<input type='submit' value='Add to Favorites'></form>"
                    + "</div>"
                    });
                }
               google.maps.event.addListener(markers[i], 'click', function () {
                    infowindows[this.id].open(map, markers[this.id]);
                });

        } //end of for loop
        
    }) // end of AJAX get request
    
} // end of fullquery function

fullquery();

}