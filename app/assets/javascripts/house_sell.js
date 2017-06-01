var url = window.location.pathname

var split = url.split('/')

if (split[2] == "house_sell"){

    function initMap() {
        var url = window.location.pathname

        var split = url.split('/')

        var query = split[split.length-1]

        var fullquery = function(){
            $.get(query +'.json', function(data){

                //the next 4 lines check if address is a street address as opposed to a general location like zip or city
                var streetchecker;

                if (data.results[0].address_components[0].types[0]){
                    streetchecker = data.results[0].address_components[0].types[0];
                }

                var latlong = data.results[0].geometry.location;

                if (!streetchecker){ //if statement for if address is NOT a street address
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 13,
                        center: latlong
                    });
                }

                else{ //considtion for if location is a specific address
                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 16,
                        center: latlong
                    });

                    //marker for address; currently cannot be dragged to update 
                    var marker = new google.maps.Marker({
                        animation: google.maps.Animation.DROP,
                        position: latlong,
                        map: map,
                        title: 'Add your listing information'
                    });
                }
            }   
        )}
        fullquery();
    }
}