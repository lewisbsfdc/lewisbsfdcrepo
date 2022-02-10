@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount () {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        //String x  = request.requestURI;
        //Integer startpos = x.indexOf('/', 2);
        
        //String accountId = request.requestURI.substring(startpos + 1,
        //  request.requestURI.lastIndexOf('/')+1);
        //Account result =  [SELECT Id, Name
        //                FROM Account
        //                WHERE Id = :accountId];
        //List<Contact> lstContact = [Select Id, Name from Contact where AccountId = :accountId];

        String accId = request.requestURI.substringBetween('Accounts/', '/contacts');
        system.debug('accId - > ' + accId);
        Account result = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                       FROM Account WHERE Id = :accId];
        
        
        return result;
    }
    @HttpPost
    global static String createAccount(String name, String numberOfEmployees,
        String inType, String description ) {
        Account newAcct = new Account(
            Name=name,
            NumberOfEmployees = Integer.valueOf(numberOfEmployees),
            Type  = inType,
            Description = description);
        try {
        insert newAcct;
        }
        catch (Exception e) {
            return 'Error -> ' + e.getMessage();    
        }
        return newAcct.Id;
    }    
    
    
}