public class LeadEnrollButton_HF {
    @AuraEnabled
    public static List<String>  getLOBData() {
        List<String> lstRetLOB = new List<String>();
        //List<Schema.Picklistentry> lstLOB = User.sObjectType.getDescribe().fields.getmap().get('Line_of_Business_Capability_HF__c').getDescribe().getpicklistValues(); 
        //for (Schema.Picklistentry lob : lstLOB){
        //    lstRetLOB.add(lob.getValue());
        //
        //}
        lstRetLOB.add('Medicaid');
        lstRetLOB.add('Essential Plan');
        lstRetLOB.add('Child Health Plus');
        lstRetLOB.add('HARP');
        
        return lstRetLOB;
    }
    @AuraEnabled
    public static Lead getLead(Id leadId){
        system.debug('leadId = ' + leadid);
        Lead led = [
            SELECT Id, Status, Email, Phone 
            FROM Lead
            WHERE Id =:leadId
        ];
        system.debug(led);
    	return [
            SELECT Id, Status, Email, Phone 
            FROM Lead
            WHERE Id =:leadId
        ][0];
        
        
    }
    @AuraEnabled
    public static String getLeadStatus(Id leadId){
        system.debug('leadId = ' + leadid);
        Lead led = [
            SELECT Id, Status, Email, Phone 
            FROM Lead
            WHERE Id =:leadId
        ];
        system.debug(led);
    	return led.Status;
        
        
    }
}