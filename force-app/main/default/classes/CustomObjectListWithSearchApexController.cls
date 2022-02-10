public with sharing class CustomObjectListWithSearchApexController {
    @AuraEnabled
    public static List<Account> searchAccountsSOQL(string searchString) {
        String queryString = 'Select id, name,type,industry from Account ';
        if(searchString!=null && searchString!=''){
            searchString = '%'+string.escapeSingleQuotes(searchString)+'%'; 
            queryString = queryString+ 'where Name Like:searchString';
        }
        queryString = queryString + ' Limit 10000';
        List<Account> accList = database.query(queryString);
        
        return accList;
    }


    @AuraEnabled
    public static List<Cust_Object_1__c> searchCustomObjectSOQL(string searchString) {
        String queryString = 'Select id, Name, Description__c, Number_Filter__c, checkbox__c, Account_Name__c, Account__c, Hyperlink__c from Cust_Object_1__c ';
        if(searchString!=null && searchString!=''){
            //searchString = '%'+string.escapeSingleQuotes(searchString)+'%';
            //Double dollarLimitSearch = Double.valueOf(searchString);
            system.debug('searchString -> ' + searchString) ;
            Double dollarLimitSearch = Double.valueOf(searchString);
            system.debug('dollarLimitSearch -> ' + dollarLimitSearch) ;
            queryString = queryString+ 'where Number_Filter__c <= :dollarLimitSearch';
        }
        system.debug('queryString -> ' + queryString);
        queryString = queryString + ' Limit 10000';
        List<Cust_Object_1__c> listReturn = database.query(queryString);
        system.debug('listReturn -> ' + listReturn);
        
        return listReturn;
    }
}