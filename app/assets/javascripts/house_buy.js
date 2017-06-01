function initMap() {

var url = window.location.pathname

var split = url.split('/')

var query = split[split.length-1]

var listings;

var fullquery = function(){
    $.get(query +'.json', function(data){
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 13,
            center: {lat: data[0].latitude, lng: data[0].longitude}
        });
        var markers = [];
        var infowindows = [];
        for (var i = 0; i < data.length; i++){
            markers[i] = new google.maps.Marker({
                animation: google.maps.Animation.DROP,
                position: {lat: data[i].latitude, lng: data[i].longitude },
                map: map,
                url: "/listings/sale/" + data[i].id,
                id: i
            }) // close of marker creator

            if (data[i].image){
                infowindows[i] = new google.maps.InfoWindow({
                    content: "<div class='infobox'>"
                    + "<a href='/listings/sale/" + data[i].id + "'><img src='" + data[i].image.gallery[0].url + "' /></a><br>" 
                    + data[i].address + " " + data[i].street + " " + data[i].city + " " + data[i].state + " " + data[i].zip 
                    + "<br> List Price: $" + data[i].price
                    + "<br><a href='/listings/sale/" + data[i].id + "'> More Info </a>"
                    + " | "
                    + "<form action='/listings/sale/" + data[i].id + "/favorite' method='POST'>"
                    + "<input type='hidden' name='authenticity_token' value='<%= form_authenticity_token %>'>"
                    +"<input type='submit' value='Add to Favorites'></form>"
                    + "</div>"
                });
                }
                else{
                    infowindows[i] = new google.maps.InfoWindow({
                    content: "<div class='infobox'>"
                    + data[i].address + " " + data[i].street + " " + data[i].city + " " + data[i].state + " " + data[i].zip 
                    + "<br> List Price: $" + data[i].price
                    + "<br><a href='/listings/sale/" + data[i].id + "'> More Info </a>"
                    + " | "
                    + "<form action='/listings/sale/" + data[i].id + "/favorite' method='POST'>"
                    + "<input type='hidden' name='authenticity_token' value='<%= form_authenticity_token %>'>"
                    +"<input type='submit' value='Add to Favorites'></form>"
                    + "</div>"
                    });
                }
               google.maps.event.addListener(markers[i], 'click', function () {
                    infowindows[this.id].open(map, markers[this.id]);
                });

        } //close of for loop
        
    })
}

fullquery();

}