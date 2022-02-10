public with sharing class LoginUserIP_Ctrl {
    public static String userIpAddress {get; set;}
    public static String userCountry {get; set;}
    
//ipstack key c123c470a850acb65454497a9b84b34d
//example http://api.ipstack.com/73.10.11.21?access_key=c123c470a850acb65454497a9b84b34d
    // Constructor...
    public LoginUserIP_Ctrl(){
        userIpAddress = GetUserIPAddress();
        System.debug('#### userIpAddress = '+userIpAddress);

       
        string endpoint = generateBaseEndpoint(userIpAddress);
        HttpRequest req = new HttpRequest();  
        req.setMethod('GET');
        req.setEndpoint(endpoint);      
        Http h = new Http();
        HttpResponse resp = h.send(req);
        String jsonInput = resp.getBody(); 
        //userCountry = jsonInput;
        Map<String, Object> mapTrans =(Map<String, Object>) JSON.deserializeUntyped(jsonInput);
        userCountry = String.valueOf(mapTrans.get('country_code'));



        //userCountry = 'United States';
    }
    
    // Method to get IP Address...
    public static String GetUserIPAddress() {
        string ReturnValue = '';
        Map<String, String> mapHeaders = ApexPages.currentPage().getHeaders();   
        System.debug('#### mapHeaders = '+mapHeaders.keySet());
        If(mapHeaders!=null){
            System.debug('#### Headers are not null--');
            String clientIP ='';
            If(mapHeaders.containsKey('True-Client-IP')){
                System.debug('#### Conatins Key');
                clientIP = mapHeaders.get('True-Client-IP'); // IP of the user when call will be caching e.g. integration.
                ReturnValue = clientIP;
            }else{
                String X_Salesforce_SIP = mapHeaders.get('X-Salesforce-SIP'); // Salesforce IP Address like Sandbox, Production, Developer
                System.debug('#### SalesforceIP = '+X_Salesforce_SIP);
                ReturnValue = X_Salesforce_SIP;
            }
            
        }
        return ReturnValue;
            
    } // GetUserIPAddress

    public String generateBaseEndpoint (String ip){
        String endpoint = 'http://api.ipstack.com/' + ip + '?access_key=c123c470a850acb65454497a9b84b34d';
        return endpoint;
    }
}