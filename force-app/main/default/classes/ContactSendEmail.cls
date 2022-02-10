global class ContactSendEmail implements Database.Batchable<sObject>,  Database.Stateful, Schedulable {
    String query;

    global void execute(SchedulableContext SC){
     ApplicationReadWriteMode mode = System.getApplicationReadWriteMode();
     if (mode != ApplicationReadWriteMode.READ_ONLY){
        ContactSendEmail execBatcher = new ContactSendEmail();
        Database.ExecuteBatch (execBatcher, 100);
     }
    }    
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        system.debug('Start');
        query = 'Select Id, Name, AccountId from Opportunity order By CreatedDate desc Limit 2';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity> emailAddresses) {
        SendEmail();
    }
        
    global void finish(Database.BatchableContext BC){
        
    }
    
    public static void SendEmail() {
        system.debug('Start Send Email');
        // First, reserve email capacity for the current Apex transaction to ensure
        // that we won't exceed our daily email limits when sending email after
        // the current transaction is committed.
        Messaging.reserveSingleEmailCapacity(2);
        
        // Processes and actions involved in the Apex transaction occur next,
        // which conclude with sending a single email.
        
        // Now create a new single email message object
        // that will send out a single email to the addresses in the To, CC & BCC list.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        // Strings to hold the email addresses to which you are sending the email.
        String[] toAddresses = new String[] {'9086127770@tmomail.net'}; 
        String[] ccAddresses = new String[] {'lrblau@gmail.com'};
          
        
        // Assign the addresses for the To and CC lists to the mail object.
        mail.setToAddresses(toAddresses);
        mail.setCcAddresses(ccAddresses);
        
        // Specify the address used when the recipients reply to the email. 
        mail.setReplyTo('lrlbau@yahoo.com');
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('Salesforce Email');
        
        // Specify the subject line for your email address.
        mail.setSubject('Reminder');
        
        // Set to True if you want to BCC yourself on the email.
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setPlainTextBody('Take your medicine');
        
        mail.setHtmlBody('Your email has been created');
        
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        system.debug('End Send Email');
    }
}