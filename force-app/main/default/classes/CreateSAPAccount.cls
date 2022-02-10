public with sharing class CreateSAPAccount {
	@AuraEnabled
    public static String  createSAPId (string accId){
  		system.debug('SAP');
        Account acc = [Select Sap_Id__c from Account where Id = :accId];
        String SAPId = String.valueOf( Integer.valueof((math.random() * 100000)));
        acc.Sap_Id__c = SAPId;
        update acc;
        system.debug('SAPId --> ' + SAPId);
        return SAPId;
    }
}