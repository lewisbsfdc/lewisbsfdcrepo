public with sharing class LeadHandler {

		 public static void onAfterInsert(List<Lead> lstLead) {
		 	countLeadHouseholds(lstLead);
/*		 	
		 	Map<String, String> mapLstLead = new Map<String, String> ();
		 	Set<ID> setLHId = new Set<ID>();
		 	Map<Id , Integer> mapNewLead = new Map<Id , Integer>();
		 	system.debug('lstNewLead.size ->  ' + lstNewLead.size());
			for(Lead c : lstNewLead) {
			     if(c.Lead_Household__c != null) {
			         setLHId.add(c.Lead_Household__c);
			         //if(mapNewLead.ContainsKey(c.Lead_Household__c))
			         //    {
			         //        mapNewLead.put(c.Lead_Household__c , mapNewLead.get(c.Lead_Household__c) + 1);
			         //    }
			         //else
			         //    {
			         //        mapNewLead.put(c.Lead_Household__c , 1);
			         //    }
			     }
			 }
			 MAP<Id , Lead_Household__c> mapLH = new Map<Id , Lead_Household__c>([Select id , Number_of_Leads__c , 
			 	(Select id From Leads__r) from   Lead_Household__c where id in :setLHId]);


			for(ID lhID :  mapLH.keyset()){
			       Lead_Household__c a = mapLH.get(lhID);
			       //a.CountContact__c = a.CountContact__c + mapLHNewContact.get(accID);
			       a.Number_of_Leads__c = a.Leads__r.size() ; //+ mapNewLead.get(lhID);
			}                                             
			try {
				update mapLH.values();
				}
				catch (Exception e) {
					system.debug(e.getMessage());
				}
*/
		 }

		 public static void onAfterDelete(List<Lead> lstLead) {
		 		countLeadHouseholds(lstLead);
		 }	


		 public static void countLeadHouseholds(List<Lead> lstLead) {
		 	Set<ID> setLHId = new Set<ID>();
			for(Lead c : lstLead) {
			     if(c.Lead_Household__c != null) {
			         setLHId.add(c.Lead_Household__c);
			     }
			 }
			 MAP<Id , Lead_Household__c> mapLH = new Map<Id , Lead_Household__c>([Select id , Number_of_Leads__c , 
			 	(Select id From Leads__r) from Lead_Household__c where id in :setLHId]);


			for(Id lhID :  mapLH.keyset()){
			       Lead_Household__c a = mapLH.get(lhID);
			       //a.CountContact__c = a.CountContact__c + mapLHNewContact.get(accID);
			       a.Number_of_Leads__c = a.Leads__r.size() ; //+ mapNewLead.get(lhID);
			}                                             
			try {
				update mapLH.values();
				}
				catch (Exception e) {
					system.debug(e.getMessage());
				}

		 }
}