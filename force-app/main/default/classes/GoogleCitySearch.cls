global with sharing class GoogleCitySearch {
	public GoogleCitySearch() {
        system.debug('GoogleCitySearch');
        Map<String, String> mapHeaders = ApexPages.currentPage().getHeaders();
		for (String key : mapHeaders.keySet()){
            system.debug('key -> ' + key + '; value -> ' + mapHeaders.get(key));
        }
	}


@AuraEnabled
    public static string getSuggestions(String input) {
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
                + '&types=(cities)' + getKey();
        String response = getResponse(url);
        return response;
    }


@AuraEnabled
    public static string getPlaces(String input) {
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
                + '&libraries=places' + getKey();
        String response = getResponse(url);
        return response;
    }


@RemoteAction
    public static string addressAutoComplete( String lati, String longi, String input) {
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
                + '&location=' + lati + ',' + longi +'&radius=500' + getKey();
         //       + '&location=40.8437777,-73.1136284&radius=500' + getKey();
         //system.debug('url -> '+ url);
        String response = getResponse(url);
        return response;
    }


@AuraEnabled
    public static string getLocations(String input, String lati, String longi) {
        String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
                + '&location=' + lati + ',' + longi +'&radius=500' + getKey();
         //       + '&location=40.8437777,-73.1136284&radius=500' + getKey();
         //system.debug('url -> '+ url);
        String response = getResponse(url);
        return response;
    }



@RemoteAction
    public static string getPlaceDetails(String placeId) {
        String url = 'https://maps.googleapis.com/maps/api/place/details/json?'
                + 'placeid=' + EncodingUtil.urlEncode(placeId, 'UTF-8')
                + getKey(); 
        String response = getResponse(url);
        return response;
    }
 
    public static string getResponse(string strURL){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(strURL);
        req.setTimeout(120000);
        res = h.send(req); 
        String responseBody = res.getBody(); 
        return responseBody;
    }
 
    public static string getKey(){
        string key = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';
        string output = '&key=' + key;   
        return output;
    }
}