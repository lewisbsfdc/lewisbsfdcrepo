public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        // Perform isAccessible() checking first, then
        return [SELECT Id, Name, Price__c, Quantity__c, Packed__c, CreatedDate 
                FROM Camping_Item__c];
    }    

    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c camping_Item) {
        // Perform isUpdatable() checking first, then
        system.debug('Camping_Item - > ' + camping_Item);
        upsert camping_Item;
        return camping_Item;
    }



}