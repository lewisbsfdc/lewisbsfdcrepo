public with sharing class OfferInitController {
    @AuraEnabled
    public String emailTemplateID { get;set; }
    @AuraEnabled
    public String emailTemplateName { get;set; }
    @AuraEnabled
    public String emailTemplateSubject { get;set; }
    @AuraEnabled
    public String emailTemplateBody { get;set; }
    @AuraEnabled
    public String candidateName { get;set; }
    @AuraEnabled
    public String candidateEmail { get;set; }
    @AuraEnabled
    public String PositionName { get;set; }
    @AuraEnabled
    public Boolean SendSuccessful { get;set; }
    @AuraEnabled
    public String SendResults { get;set; }    
    @AuraEnabled
    public List <String> lstRecords { get;set; }

    public void OfferInitController () {
        
    }

    @AuraEnabled
    public static List<OfferInitController.EmailTemplateWrapper> getEmailTemplatesNames() {
        
        list<OfferInitController.EmailTemplateWrapper> lstETW= new list<OfferInitController.EmailTemplateWrapper> ();
        
        // CRUD / FLS Check - Create a map with the object names and fields for CRUD\FLS check - 
       //mapObjectsFields = new Map<String, Set<String>>(); 
        

        
        // CRUD\FLS Check: Before running the SOQL query check if the user who is invoking this method has access to the Object and to the fields requested
        
        //if (Sparkle_Helper.UserHasAccessToObjectsAndFields(mapObjectsFields))
        //{
            
            // Grab Position level from associated Position record
             
       
            
            String soql = 'SELECT FolderId,Id,IsActive,Name,NamespacePrefix,Subject FROM EmailTemplate where Folder.Name ='+'\'' + 'Lead Email Templates' +'\'' + 
                'and IsActive = true '; // and Name LIKE '
                // +'\'' + '%'+ positionLevel +'%' +'\'';
            
            System.debug('######## soql: ' + soql);
            
            List<EmailTemplate> lstQueriedRecords = Database.query(soql);
            
            System.debug('######## lstQueriedRecords: ' + lstQueriedRecords);
           
           
            for (EmailTemplate e: lstQueriedRecords)
            {
                System.debug('######## e: ' + e);
                OfferInitController.EmailTemplateWrapper etw = new OfferInitController.EmailTemplateWrapper (e);
                //OfferLetterCompController i = new OfferLetterCompController();
                
                
                //i.emailTemplateID = String.valueOf( e.get('id') );
                //if (e.Name != null)
                //{                
                //    i.emailTemplateName = Sparkle_Helper.GetSobjectField(e, 'Name');
                //    i.candidateName = cName;
                //    i.candidateEmail = cEmail;
                //    i.PositionName = posName;
                //}
                 
                lstETW.add(etw);

                //System.debug('######## i: ' + i); 
            }
            
            
        //}
        
        //System.debug('######## lstReturnRecords: ' + lstReturnRecords);
        
        return lstETW;
       } 


        public with sharing class EmailTemplateWrapper{
            @AuraEnabled
            public String name{get; set;}
            @AuraEnabled
            public EmailTemplate emailTemplate {get; set;}
           // @AuraEnabled
           // public Lead led {get; set;}

            public EmailTemplateWrapper(EmailTemplate inEmailTemplate){
                system.debug('template Name --> ' + inEmailTemplate.Name);
                this.name = inEmailTemplate.Name;
                this.emailTemplate = inEmailTemplate;
                //this.led = led;

            } // end LeadWrapper Constructor

        } //end LeadWrapper Class
        
        
    }