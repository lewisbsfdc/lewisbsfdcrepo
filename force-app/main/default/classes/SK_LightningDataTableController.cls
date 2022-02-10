public class SK_LightningDataTableController {
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
}