public with sharing class GoogleAddressController {
    public GoogleAddressData addressData {get; set;} 
    public Map<String, String> componentForm {get; set;}
    public Map<String, Object> myMap {get; set;}
    public String s {set; get;}
    public String s2 {set; get;}
    public String streetNumber {set; get;}
    public static final String APIKey = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';
    //public String apiKey1 {
    //    get { return apiKey1; }
    //    set { apiKey1 = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY'; }
    //}
    public String apiKey1 {set; get;}

	public GoogleAddressController() {
        addressData = new GoogleAddressData();
        addressData.googleSearch = 'Search Text';
        componentForm = new Map<String, String>();
        myMap = new Map<String, Object>();
        apiKey1 = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';

		
	}
@RemoteAction
public static String getAPIKey (){
    return APIKey;
}

@RemoteAction
public static List<String> getContactName (String searchString){
    system.debug('searchString -> '  + searchString);
      List<String> lstRet = new List<String> 
    {
      '1234 Alpha Street Seattle, WA 98101',
      '123 Argon Road Seattle, WA 98102',
      '12 Aspen Terrace Seattle, WA 98103',
      'From Server',
      'C',
      'C++',
      'Clojure',
      'COBOL',
      'ColdFusion',
      'Erlang',
      'Fortran',
      'Groovy',
      'Haskell',
      'Java',
      'JavaScript',
      'Lisp',
      'Perl',
      'PHP',
      'Python',
      'Ruby',
      'Scala',
      'Scheme'
    };
    return lstRet;
}






  public PageReference setVariable(){
        //myMap.putAll( system.currentpagereference().getParameters().get('myParam') );
        //system.debug('myMap -> ' + myMap);

        String value1 = system.currentpagereference().getParameters().get('myParam');
        system.debug('value1 -> ' + value1);
        //myMap = (Map<String, String>)JSON.deserializeStrict(value1);

        myMap =  (Map<String, Object>) JSON.deserializeUntyped(value1);

        for (String key : myMap.keySet()){
            system.debug('key    -> ' + key);
            system.debug('value  -> ' + String.valueOf(myMap.get(key) )  );         
        }





        //List <String> paramString = value1.split('|');
        //system.debug('size -> ' + paramString.size());

        //suserInputAddressForAutocompleteystem.debug('1ST Item in list -> ' + paramString[0]);
        //system.debug('2ND Item in list -> ' + paramString[1]);


        //for (Integer i = 0; i < paramString.size(); i += 2  ){
        //    myMap.put(paramString[i], paramString[i+1] );
        //    system.debug('key    -> ' + paramString[i]);
        //    system.debug('value  -> ' + paramString[i+1]);
        //}



        //system.debug('setVariable');
        //system.debug('myMap -> ' + myMap );
        //system.debug('s -> ' + s );
        //system.debug('s2 -> ' + s2 );
        //system.debug('componentForm -> ' + componentForm);
        //system.debug('streetNumber -> ' + streetNumber );
        return null;

    }
@RemoteAction
    public static GoogleAddress getPlaceDetails(String placeId) {
        GoogleAddress googAddr = new GoogleAddress();

        String url = 'https://maps.googleapis.com/maps/api/place/details/json?'
                + 'placeid=' + EncodingUtil.urlEncode(placeId, 'UTF-8')
                + getKey(); 
        String response = GoogleCitySearch.getResponse(url);
        //return response;
        Map<String, Object> mapResponse =(Map<String, Object>) JSON.deserializeUntyped(response);
        Map<String, Object> mapAddress = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(mapResponse.get('result')));

        for (Object addressComponent : (List<Object>) mapAddress.get('address_components') ){
            setGoogleAddressfields(addressComponent, googAddr);
        }

        return googAddr;
    }
 




  @RemoteAction
    public static String addressAutoComplete(Decimal latitude, Decimal longitude, String address) {
        
        //return GoogleCitySearch.addressAutoComplete(address, String.valueOf(latitude), String.valueOf(longitude));

        String endpoint = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                + 'input=' + EncodingUtil.urlEncode(address, 'UTF-8') 
                + '&libraries=places&'
                + '&location=' + String.valueOf(latitude) + ',' + String.valueOf(longitude) +'&radius=500' + getKey();





//"https://maps.googleapis.com/maps/api/js?key=AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY&signed_in=true&libraries=places&callback=initAutocomplete">



        //String endpoint = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1&location=40.8437777,-73.1136284&radius=500&key=AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';

        // Init callout
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();

        request.setMethod('GET');
        request.setTimeout(120000);
        request.setEndPoint(endpoint);
        request.setHeader('Content-Type', 'application/json');

        // Handle Response
        HttpResponse response = httpProtocol.send(request);

        // Response
        // System.debug('******** ' + response.getStatusCode());
        System.debug('******** ' + JSON.serialize(response.getBody()));

        return response.getBody();
    }

    @RemoteAction
    public static String getAddressSet(String SearchText){
        //String APIKey = '';
        String result = null;
        system.debug('SearchText is ' + SearchText);
        
        //string x = '4';
        try{
            if(SearchText != null){
                //String APIUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + SearchText.replace(' ', '%20') + '&key=' + APIKey; 
                String APIUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1&location=40.8437777,-73.1136284&radius=500&key=AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';

                //String APIUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + x.replace(' ', '%20') + '&key=' + APIKey; 
                system.debug('APIUrl is ' + APIUrl);
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(APIURL);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                system.debug('statusCode is ' + statusCode);
                if(statusCode == 200){
                    system.debug('API invoked successfully');
                    result = res.getBody();
                }



            }
        }
        catch(exception e){
            //Handling exception
            system.debug(e.getMessage());
        }
        return result;




    }
     public static string getKey(){
        string key = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';
        string output = '&key=' + key;   
        return output;
    }


    //private  void setGoogleAddressfields (Map<String, Object> ac, GoogleAddress ga){
    private  static void setGoogleAddressfields (Object adressobject, GoogleAddress ga){
        
        Map<String, Object> ac = (Map<String, Object>) adressobject;
        List<Object> lstObjTypes = (List<Object>) ac.get('types');
        List<String> lstTypes = new List<String> ();

        for (Object t : lstObjTypes ){
            lstTypes.add(String.valueOf(t));
        }


        system.debug('lstTypes -> '+ lstTypes);
        for (String addrType : lstTypes) {
            switch on addrType {
                when 'street_number'{
                    ga.street_number = String.valueOf(ac.get('long_name' ));
                }
                when 'route'{
                    ga.route = String.valueOf(ac.get('long_name' ));
                }
                when 'locality'{
                    ga.locality = String.valueOf(ac.get('long_name' ));
                }
                when 'administrative_area_level_1'{
                    ga.administrative_area_level_1 = String.valueOf(ac.get('long_name' ));
                }
                when 'country'{
                    ga.country = String.valueOf(ac.get('long_name' ));
                }
                when 'postal_code'{
                    ga.postal_code = String.valueOf(ac.get('long_name' ));
                }
            }

        }
   }


    public class GoogleAddress{

    String street_number;
    String route;
  String locality;
  String administrative_area_level_1;
  String country;
  String postal_code;
}
 


   //https://maps.googleapis.com/maps/api/place/autocomplete/json?input='
   //         + EncodingUtil.urlEncode(input, 'UTF-8')
   //         + '&types=' + types
   //         + '&key=' + GoogleMapsController.getGoogleMapsAPIKey();

}