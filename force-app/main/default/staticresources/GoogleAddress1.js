
var placeSearch, autocomplete;
var myMap ;

var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  // Create the autocomplete object, restricting the search predictions to
  // geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      document.getElementById('autocomplete'), {types: ['geocode']});

  // Avoid paying for data that you don't need by restricting the set of
  // place fields that are returned to just the address components.
  autocomplete.setFields(['address_component']);

  // When the user selects an address from the drop-down, populate the
  // address fields in the form.
  autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();
  //myMap = new Map();
  console.log('myMap Before', myMap);


  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }
  myMap = new Map();
  // { "name":"John", "age":30, "city":"New York"}

  // Get each component of the address from the place details,
  // and then fill-in the corresponding field on the form.
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {

      var val = place.address_components[i][componentForm[addressType]];

      
      //myMap = myMap + addressType + '|' + val + '|';
      myMap.set(addressType, val);
      console.log('val', val);
      document.getElementById(addressType).value = val;
    }    
  }
  console.log('componentForm', componentForm);
  console.log('myMap', myMap);

var myJson = {};
myJson = mapToObj(myMap);
var json = JSON.stringify(myJson);
console.log('json', json);
  //console.log('stringify', JSON.stringify(myMap) );

//var myJson = {};
//myJson.myMap = myMap;
//myJson.myString = myString;
//var json = JSON.stringify(myMap);

//console.log('json' , json);
  assignVariable2(json);
 // document.getElementById('hdnField').value = 'From fillInAddress';
}

// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle(
          {center: geolocation, radius: position.coords.accuracy});
      autocomplete.setBounds(circle.getBounds());
    });
  }
}

function mapToObj(map){
  const obj = {}
  for (let [k,v] of map)
    obj[k] = v
  return obj
}

function clickMe() {
            methodOneInJavascript('INVOKED!');
        }
