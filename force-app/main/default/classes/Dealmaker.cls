public with sharing class Dealmaker {
    @AuraEnabled
    public Static Map<String, List<Opportunity> > getOpportunity (string oppId){
    	Map<String, List<Opportunity> > mapOpp = new  Map<String, List<Opportunity> > ();
        system.debug('Dealmaker class');
        if (oppId == null){
            return null;
        }
        List<Opportunity> lstOpportunity =[select Id, name, AccountId, stageName 
                                from Opportunity 
                                where Id = :oppId
                                order by LastModifiedDate desc Limit 1 ]; // 

        mapOpp.put(lstOpportunity[0].Id, lstOpportunity);                      
        system.debug(lstOpportunity);
        if (lstOpportunity.isEmpty()){
            system.debug('No Opportunity');
            return null;       
        }
        else {
            system.debug('Opportunity found');
            return mapOpp ;     
        }    
	}

}