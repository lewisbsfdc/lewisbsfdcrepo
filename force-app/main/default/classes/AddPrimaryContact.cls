global class AddPrimaryContact implements Queueable {
    
    private Contact queueContact;
    private String contactState;
    
    public AddPrimaryContact(){}
    
    public AddPrimaryContact(Contact con, String state){
        queueContact = con;
        contactState = state;
    }
    
    public void execute(QueueableContext context){
        
        List<Account> accList = [select id,name from Account  where BillingState =: contactState limit 200];
        List<Contact>conList = new List<Contact>();
        for(account acl : accList){
            Contact cont = queueContact.clone(false);
            cont.AccountId=acl.id;
            conList.add(cont);
        }
        insert conList;
        
    }
}