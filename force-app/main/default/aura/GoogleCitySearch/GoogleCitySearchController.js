({
getCities : function(component, event, helper){ 
     
    var params = {
      "input" : component.get('v.location') ,
      "lati" : component.get('v.latitude') ,
      "longi" : component.get('v.longitude') 
    } 
    console.log('params -> ' , params );
    helper.callServer(component,"c.getLocations",function(response){
        var resp = JSON.parse(response);    
        console.log(resp.predictions);
        component.set('v.predictions',resp.predictions);    
    },params);  
 
},

getCityDetails : function(component, event, helper){         
 
    var selectedItem = event.currentTarget;
        var placeid = selectedItem.dataset.placeid;
 
    var params = {
       "placeId" : placeid      
    } 
 
    helper.callServer(component,"c.getPlaceDetails",function(response){
        var placeDetails = JSON.parse(response);         
        component.set('v.location',placeDetails.result.name);   
        component.set('v.predictions',[]); 
    },params);  
 
},
doInit: function(component,event,helper){
        console.log('doInit');
       // if(window.navigator.geoLocation){
       //     console.log("capability is there");
       //     window.navigator.geolocation.getCurrentPosition(function(position) {
       //        // var latit = position.coords.latitude;
       //        // var longit = position.coords.longitude;
       //        // console.log('latit', latit);
       //        // console.log('longit', longit);
       //        // component.set("v.latitude",latit);
       //        // component.set("v.longitude",longit);
       //     };
       // }else{
       //     console.log("No Capability");
       //   }

    navigator.geolocation.getCurrentPosition(function(e) {
        console.log(e.coords.latitude + ', ' + e.coords.longitude);
       component.set("v.latitude",e.coords.latitude);
       component.set("v.longitude",e.coords.longitude);
    }, function() {
        console.log('There was an error.');
    });

       // });

   }


})