trigger ChildObject on Child_Object__c (before insert) {
    system.debug('Child Object C trigger fired');
    if (Trigger.isBefore && Trigger.isInsert){
        system.debug('IsNew -> ' + Trigger.New);
        //Master_Object__c mo = [ Select Id, Account__c from Master_Object__c where Id = :Trigger.New[0].Account__c Limit 1];
        List<Contact> c = [ Select Id, AccountId from Contact where AccountId = :Trigger.New[0].Account__c Limit 1];
        Trigger.New[0].Contact__c = c[0].Id;
    }
}