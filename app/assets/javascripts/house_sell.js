var url = window.location.pathname
console.log("URL:", url)
var split = url.split('/')

if (split[2] == "house_sell"){

    window.initMapSell = function () {
        var url = window.location.pathname

        var split = url.split('/')

        var query = split[split.length-1]

        var img = "/assets/octolocator-9a92a78840247e9ba23bab7e112f0df57eb994539283dcf71dc062476748d490.png"

        var fullquery = function(){
            $.get(query +'.json', function(data){
                    console.log("DATA:", data);
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
                            title: 'Add your listing information',
                            icon: img
                            });
                        }
            }   
        )}
        fullquery();
    }
}