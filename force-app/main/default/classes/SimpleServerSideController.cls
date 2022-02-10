public class SimpleServerSideController {
    //Use @AuraEnabled to enable client- and server-side access to the method
    @AuraEnabled
    public static String serverEcho(String firstName) {
        return ('Hello from the server, ' + firstName);
    }
    @AuraEnabled
    public static List<SimpleServerSideController.LeadWrapper> getLeads(Id LHId) {
        // Perform isAccessible() checks here
        list<SimpleServerSideController.LeadWrapper> lstLeadWrapper = new list<SimpleServerSideController.LeadWrapper> ();
        for (Lead led : [SELECT Name, Email FROM Lead WHERE Lead_Household__c = :LHId] ) {
            system.debug(led);
            SimpleServerSideController.LeadWrapper lw = new SimpleServerSideController.LeadWrapper(led) ;
            lstLeadWrapper.add(lw);
            //lstLeadWrapper.add(SimpleServerSideController.LeadWrapper(led) );
        }
        return lstLeadWrapper;
    }

    @AuraEnabled
    public static String sendMassEmail(String lstLeadWrapper){

        String ret = 'SendEmail1 No Message ';
        string emailRecipients = '( ';
        List <Lead> lstLead = new List<Lead>();
        system.debug(ret);
        system.debug('lstLeadWrapper - > ' + lstLeadWrapper);
// **********
       JSONParser parser = JSON.createParser(lstLeadWrapper);
        map<String, String> mapLeadId = new map<String, String>();
        string LeadId, Leadname;

        while (parser.nextToken() != null) {
                if (parser.getText() ==  'Id') {
                    parser.nextToken();
                    LeadId = parser.getText();
                }
         
                 if (parser.getText() ==  'Name') {
                    parser.nextToken();
                    LeadName = parser.getText();
                }       
                 if (parser.getText() == 'sendEmail'){
                    parser.nextToken();

                    if (parser.getText() == 'true') {
                        mapLeadId.put(LeadId, LeadName); 
                    }
                } 
        }//End while
// **********
        list<String> lstLead1 = new list<String> ();
        for (String lw :  mapLeadId.keyset()){
            system.debug(lw);
                emailRecipients = emailRecipients + mapLeadId.get(lw) + '; ' ;
                lstLead1.add(lw);
        } // end for
        if (mapLeadId.size() > 0) {
            ret = 'Email will be sent to' + emailRecipients + ') ' ;
        }
        sendEmailWithTemplate(   lstLead1   );
        return ret ;
    }


    public static void sendEmailWithTemplate ( list<string> lstLeadId ) {

         //List<contact> lstcon=[Select id from Lead where id in :lstLeadId];
         List<Id> lstids= new List<Id>();
         for(String c:lstLeadId) {
            lstids.add(c);
         }
         EmailTemplate et=[Select id from EmailTemplate where name = 'IM Your Rep' limit 1];
         
         Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
         mail.setTargetObjectIds(lstIds);
         mail.setSenderDisplayName(UserInfo.getName());
         mail.setTemplateId(et.id);
         Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });


      }



    public with sharing class LeadWrapper{
        @AuraEnabled
        public Boolean sendEmail{get; set;}
        @AuraEnabled
        public Lead led {get; set;}

        public LeadWrapper(Lead led){
            this.sendEmail = false;
            this.led = led;
        } // end LeadWrapper Constructor

    } //end LeadWrapper Class
}