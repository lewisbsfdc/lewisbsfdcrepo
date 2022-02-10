@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    public static void setup(){
        
        List<Account> accList = new List<Account>();
        for(integer ing =0;ing<50; ing++){
            Account acc = new Account(Name='TEst Acc',BillingState ='NY');
            accList.add(acc);
        }    
        
        for(integer ing =0;ing<50; ing++){
            Account acc = new Account(Name='TEst Acc',BillingState ='CA');
            accList.add(acc);
        } 
        
        insert accList;
        
        Contact con = new Contact(FirstName = 'First', LastName='TestContact');
        insert con;
    }
    
   static testmethod  void testAcount(){
        
        contact con = [select id,name,LastName, AccountId from contact where LastName='TestContact'];
         Test.startTest();
         
        AddPrimaryContact ad = new AddPrimaryContact ();
        AddPrimaryContact updater = new AddPrimaryContact (con, 'CA');
        // startTest/stopTest block to force async processes to run
               System.enqueueJob(ad);
        ID jobID = System.enqueueJob(updater);
        Test.stopTest();       
        system.debug('jobID -> ' + jobID);
    }
}