global class TestBatcher implements Database.Batchable<sObject>,  Database.Stateful {
	
	String query;
	global TestHandler.ContactReturn contactReturn;
	
	global TestBatcher() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		system.debug('Start');
		query = 'Select Id, Name, AccountId from Opportunity order By CreatedDate desc Limit 2';
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Opportunity> lstOpp) {

   		system.debug('execute');
   		contactReturn = new TestHandler.ContactReturn();
   		system.debug('lstOpp -> ' + lstOpp);
   		contactReturn = TestHandler.processOpportunity(lstOpp);
   		system.debug('contactReturn.opp -> ' + contactReturn.opp);

	
	}
	
	global void finish(Database.BatchableContext BC) {
		system.debug('finish;  -> contactReturn.opp' + contactReturn.opp);
		for (Opportunity opp1 : contactReturn.opp ){
			system.debug('Opp.Name -> ' + opp1.Name + ' opp.Id -> ' + opp1.Id);
		}
		for (Account acct :contactReturn.lstAccount ){
			system.debug('acct.Name -> ' + acct.Name + ' acct.Id -> ' + acct.Id);
		}
		for (String contactId :contactReturn.mapContact.keySet() ){
			system.debug('contactId -> ' + contactId+ ' cont Name -> ' + contactReturn.mapContact.get(contactId).Name);
		}
		
	}
	
}