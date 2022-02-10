public with sharing class NokiaAPI {
 
   public list <Account> acc {get;set;}
   public list<Contact> con{get;set;}
   public list<Opportunity> opty{get;set;}
   public list<String> nameSearch{get;set;}
   public list<returnWrapper> returnAddresses{get;set;}
   public string searchstring {get;set;} 
   public string value1 {get;set;} 
   public String apiKey {get;set;} 
   public String apiConfig {get;set;} 
   //global String endpoint {get;set;}
   //global String apiId {get;set;}
   //global String apiCode {get;set;}
   
    public NokiaAPI() {
      system.debug('Searchclass');


   } 
    
   //public Searchclass(ApexPages.StandardController controller) {
     
   //}  
   public void search(){  
     if(searchstring != null && searchstring != '' ){  
     string acQuery = 'select Id, Name, Email from Contact where Name like \'%'+searchstring+'%\'  Limit 5';
     string searchquery='select Name, Phone from Account where Name like \'%'+searchstring+'%\'  Limit 10';  
     string searchquery1='select Name, Phone from Contact where Name like \'%'+searchstring+'%\'  Limit 10';
     string searchquery2='select Name, StageName from Opportunity where Name like \'%'+searchstring+'%\'  Limit 10';
     acc= Database.query(searchquery); 
         system.debug('acc = ' + acc);
     con= Database.query(searchquery1); 
                 system.debug('con = ' + con);
     opty= Database.query(searchquery2); 
         system.debug('opty = ' + opty);
     }
  }

@RemoteAction
public static List<returnWrapper> getContactName (String searchString){
    system.debug('searchString -> '  + searchString);
    string acQuery = 'select Id, Name, Email from Contact where Name like \''+searchstring+'%\' Order by FirstName Limit 5';
    List<Contact> listCon= Database.query(acQuery); 
    system.debug('con = ' + listCon);
    List<returnWrapper> lstRet = new List<returnWrapper>();
    for (Contact con : listCon){
        returnWrapper retWrap = new returnWrapper();
        retWrap.Name = con.Name;
        retWrap.Id = con.Id;
        retWrap.Email = con.Email;
        lstRet.add(retWrap);
    }

    return lstRet;
}


public  List<returnAddress> getAddresses1 (String searchString){
    system.debug('searchString -> ' + searchString);
    List<returnAddress> lstRet = new List<returnAddress>();
   // String url = 'https://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=35&beginHighlight=%3Cmark%3E&endHighlight=%3C%2Fmark%3E&maxresults=5&app_id=g6h5BZFu7tn2XMFUMneN&app_code=xfUz5NXrT1MLm3-Zd96mBA';

    //string url = 'https://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=35&beginHighlight=%3Cmark%3E&endHighlight=%3C%2Fmark%3E&maxresults=5&app_id=g6h5BZFu7tn2XMFUMneN&app_code=xfUz5NXrT1MLm3-Zd96mBA';
    //String encodedSearchString = EncodingUtil.urlEncode(searchString, 'UTF-8');
    //string url1 = endpoint + '?query=' + encodedSearchString + '&app_id=' + apiId + '&app_code=' + apiCode;
    //system.debug ('url -> ' + url);
    //system.debug ('url1 -> ' + url1);


    //string response = getResponse(url);
    //system.debug('response -> ' + response);
    //Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response);
    //List<Object> obj = (List<Object>) m.get('suggestions');
    //Integer i = 0;
    //for (Object o : obj){
    //    //system.debug('o ->' + o);
    //    String str = JSON.serialize(o);
    //    Map<String, Object> m1 = (Map<String, Object>) JSON.deserializeUntyped(str);
    //    system.debug('Record # ' + i++);
    //    for (String key : m1.keySet()){
    //        system.debug('key -> ' + key + ': value -> ' +  m1.get(key) ); 
    //        if (key == 'address'){
    //            Map<String, Object> mapAddr = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(m1.get(key)));
    //            for (String addrKey : mapAddr.keySet()){
    //                system.debug('addrkey -> ' + addrKey + ': value -> ' +  mapAddr.get(addrKey) );
    //            }
    //        }
    //    }
    //}

    //string x = JSON.serialize( m.get('suggestions') );
  
    //system.debug('x -> ' + x);
    //Map<String, Object> suggestions = (Map<String, Object>) JSON.deserializeUntyped(x);
    //Object x = m.get('suggestions'));
    //Map<String, Object> suggestions = (Map<String, Object>) JSON.deserializeUntyped (JSON.serialize( m.get('suggestions') )) ;

    //for (String key : suggestions.keySet()){
    //    system.debug('suggestions -> ' + key + ': value -> ' +  suggestions.get(key) ); 
    //}


    //for (String key : m.keySet()){
    //    system.debug('key -> ' + key + ': value -> ' +  m.get(key) ); 
    //}

    //system.debug('response -> ' + response);

    return lstRet;
}

@RemoteAction
public static List<returnAddress> getAddresses (String searchString, String lati, String longi){
    system.debug('searchString -> ' + searchString);
    system.debug('createSearchLIst lati -> ' + lati + '; longi -> ' + longi);
    List<returnAddress> lstRet = new List<returnAddress>();

   //// String url = 'https://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=35&beginHighlight=%3Cmark%3E&endHighlight=%3C%2Fmark%3E&maxresults=5&app_id=g6h5BZFu7tn2XMFUMneN&app_code=xfUz5NXrT1MLm3-Zd96mBA';
    if (String.isBlank(searchString) ){
        return lstRet;
    }
    string response = getResponse(getURL(searchstring, lati, longi));
    system.debug('response -> ' + response);
    Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response);
    List<Object> obj = (List<Object>) m.get('suggestions');
    Integer i = 0;
    for (Object o : obj){
        returnAddress ra = new returnAddress();
        ra.putField ( (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(o)) );
        system.debug('ra -> ' + ra);
        lstRet.add(ra);
    }
    //system.debug('response -> ' + response);
    return lstRet;
}




@RemoteAction
public static String createSearchLIst (String lati, String longi){
  system.debug('createSearchLIst lati -> ' + lati + '; longi -> ' + longi);
  if (lati != null && longi != null) {
    string qWhere = 'where DISTANCE(Location__c, GEOLOCATION(' + lati + ',' + longi + '), \'mi\')  < 3000 ';
    string qOrderBy = 'Order by FirstName Limit 50000';
    string acQuery = 'select Id, Name, Email from Contact ' + qWhere + qOrderBy;   
    system.debug('acQuery -> ' + acQuery) ;
    List<Contact> listCon= Database.query(acQuery); 
    List<returnWrapper> returnAddresses = new List<returnWrapper>();
    for (Contact con : listCon){
        returnWrapper retWrap = new returnWrapper();
        retWrap.Name = con.Name;
        retWrap.Id = con.Id;
        retWrap.Email = con.Email;
        returnAddresses.add(retWrap);
    }

    system.debug('returnAddresses -> ' + returnAddresses);
    return 'Success';
  }
  else {
    return 'Error';
  }
}


public class returnWrapper {
  String Id;
  String Name;
  String Email;
}

public class returnAddress {
  String label;
  String language;
  String countryCode;
  String locationId;
  hereAddress address;
  String matchLevel;
  String fullAddress;
  String value;

  public returnAddress(){
    address = new hereAddress();
  }

  public void putField(String fieldName, String fieldValue){
    this.label = fieldValue;
    //this.put(fieldName, fieldValue);
  }

  public void putField(Map<String, Object> mapInput){
    this.label = (String) mapInput.get('label');
    this.language = (String) mapInput.get('language');
    this.countryCode = (String) mapInput.get('countryCode');
    this.locationId = (String) mapInput.get('locationId');
    this.matchLevel = (String) mapInput.get('matchLevel');
    Map<String, Object> mapAddr = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(mapInput.get('address')));
    for (String addrKey : mapAddr.keySet()){
        system.debug('addrkey -> ' + addrKey + ': value -> ' +  mapAddr.get(addrKey) );
        switch on addrkey{
            when 'country'{
                this.address.country = (String) mapAddr.get(addrKey);
            }
            when 'state'{
                this.address.state = (String)  mapAddr.get(addrKey);
            }
            when 'city'{
                this.address.city = (String) mapAddr.get(addrKey);
            }
            when 'district'{
                this.address.district = (String) mapAddr.get(addrKey);
            }
            when 'street'{
                this.address.street = (String) mapAddr.get(addrKey);
            }
            when 'postalCode'{
                this.address.postalCode = (String)  mapAddr.get(addrKey);
            }
            when 'county'{
                this.address.county = (String) mapAddr.get(addrKey);
            }
            when 'houseNumber'{
                this.address.houseNumber = (String) mapAddr.get(addrKey);
            }
        } // end switch  
    } // end for
    this.fullAddress = concatenateAddress(this.address);
    if (this.address.houseNumber == '' ||  this.address.houseNumber == null){
        this.value = this.address.street;
    }
    else {
        this.value = this.address.houseNumber + ' ' + this.address.street;
    }

  } // putField

  public String concatenateAddress(hereAddress inAddr){
    String retAddress = '';
    if (inAddr.houseNumber != null && inAddr.houseNumber != ''){
        retAddress = inAddr.houseNumber;
    }

    if (inAddr.street != null && inAddr.street != '') {
        if (retAddress != '') {
            retAddress = retAddress + ' ' + inAddr.street;
        }
        else {
            retAddress = inAddr.street;
        }
    }

    if (inAddr.city != null && inAddr.city != '') {
        if (retAddress != '') {
            retAddress = retAddress + ' ' + inAddr.city;
        }
        else {
            retAddress = inAddr.city;
        }
    }

    if (inAddr.state != null && inAddr.state != '') {
        if (retAddress != '') {
            retAddress = retAddress + ' ' + inAddr.state;
        }
        else {
            retAddress = inAddr.state;
        }
    }

    if (inAddr.postalCode != null && inAddr.postalCode != '') {
        if (retAddress != '') {
            retAddress = retAddress + ' ' + inAddr.postalCode;
        }
        else {
            retAddress = inAddr.postalCode;
        }
    }

    return retAddress;
  } // end concatenateAddress

}

public class hereAddress {
  String country;
  String state;
  String city;
  String district;
  String street;
  String postalCode;
  String county;
  String houseNumber;

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


private static String getURL (String searchString, String lati, String longi){
    String retURL = null;
    String proximity = '';
    if (lati != null && longi != null){
        proximity = '&prox=' + lati + ',' + longi +',100000';
    }
    API_Configuration__mdt api = [Select Configuration_Field_1__c, Configuration_Field_2__c, Endpoint__c from API_Configuration__mdt where API_Name__c = 'HereWeGo' and isActive__c = true Limit 1];
    if (api != null){
        String encodedSearchString = EncodingUtil.urlEncode(searchString, 'UTF-8');
        //retURL = api.Endpoint__c + '?query=' + encodedSearchString + '&app_id=' + api.Configuration_Field_1__c + '&app_code=' + api.Configuration_Field_2__c + '&prox=' + lati + ',' + longi +',100000';
        retURL = api.Endpoint__c + '?query=' + encodedSearchString + '&app_id=' + api.Configuration_Field_1__c + '&app_code=' + api.Configuration_Field_2__c  +  proximity;
    }
    system.debug(retURL);
    return retURL;
}


}