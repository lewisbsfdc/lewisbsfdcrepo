public class SendReportEmail {
    public static void sendEmail(string reportId,string email){
        system.debug('start Send Email');
        List<Report> repList = [Select id,name from report where id=:reportId limit 1];
        if(repList.size()>0){
            system.debug('Report found');
            ApexPages.PageReference report = new ApexPages.PageReference('/'+repList[0].id+'?csv=1');
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName(repList[0].name+'.csv');
            attachment.setBody(report.getContent());
            attachment.setContentType('text/csv');
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            String[] toAddresses=email.split(',');       
            message.setSubject(repList[0].name+' Report');
            message.setPlainTextBody('The report is attached.');
            message.setToAddresses(toAddresses);
            Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
            system.debug('Report emailed');
        }
    system.debug('end Send Email');
    
    } 
}