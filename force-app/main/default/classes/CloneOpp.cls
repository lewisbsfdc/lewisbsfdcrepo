public class CloneOpp{    
  
  @AuraEnabled  
    public static Opportunity getDetailsFromOpp(string recordId){
       Opportunity opp = [select Id,Name,CampaignId, OrderNumber__c
        from Opportunity Where Id = :recordId limit 1];
       return opp ;
    }
 }