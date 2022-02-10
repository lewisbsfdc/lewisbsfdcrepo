public with sharing class TestHandler {

    public static ContactReturn contactReturn;
	public TestHandler() {
		
	}

    public class ContactReturn{
        public Map<String, Contact> mapContact;
        public List<Account> lstAccount;
        public List<Opportunity> opp;

        public ContactReturn () {
            this.mapContact = new Map<String, Contact>();
            this.lstAccount = new List<Account>();
            this.opp = new List<Opportunity>();
        }


    }

    public static ContactReturn processOpportunity(List<Opportunity> lstOpp){
        List <String> lstAcctIds = new List <String>();
        contactReturn = new ContactReturn();
        contactReturn.opp = lstOpp;
        for (Opportunity o : contactReturn.opp){
            lstAcctIds.add(o.AccountId);
        }
        contactReturn.lstAccount = [Select Id, Name from Account where Id in :lstAcctIds];
        contactReturn.mapContact = new Map<String, Contact> ([Select Id, Name from Contact where AccountId in :lstAcctIds]);



        return contactReturn;


    }


}