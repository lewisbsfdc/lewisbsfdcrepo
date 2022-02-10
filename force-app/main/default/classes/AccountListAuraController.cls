public with sharing class AccountListAuraController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [Select Id, Name, Website from Account order by Name];
    }
 
}