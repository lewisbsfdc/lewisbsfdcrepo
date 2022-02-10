public with sharing class  LeadController {
    
    @AuraEnabled
    public static Lead getLead(Id leadId) {
        return [select Id, Name, Status from Lead where Id = '00Q4100000ZzCzCEAV' Limit 1];
      //   return [select Id, Name, Status from Lead where Id = :leadId Limit 1];
    }
}