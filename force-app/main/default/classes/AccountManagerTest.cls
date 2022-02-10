@IsTest
private class AccountManagerTest {
    @isTest 
    static void testAccountGet() {
        Id recordId = createTestRecord();
        system.debug('recordId -> ' + recordId);
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://lb-trailhead-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId + '/contacts';
        request.httpMethod = 'GET';
       	RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        //System.assert(thisCase != null);
        //System.assertEquals('Test record', thisCase.Subject);
    }
    @isTest 
    static void testAccountPost() {
        // Call the method to test
        String testName = 'Ferocious Chipmunk';
        String thisAcctId = AccountManager.createAccount(
            testName, 100, 'Phone', 'Low');
        // Verify results
        System.assert(thisAcctId != null);
        Account newAccount = [SELECT Id,Name, Description, Type, NumberOfEmployees FROM Account WHERE Id=:thisAcctId];
        System.assert(newAccount != null);
        System.assertEquals(newAccount.Name, testName);
    }    
  
    
    
    static Id createTestRecord() {
        // Create test record
        Account accTest = new Account(
            Name='Test record');
        insert accTest;
        Contact conTest = new Contact(
        	FirstName = 'First',
            LastName = 'Last',
            AccountId = accTest.Id);
        insert conTest;
        system.debug('accTest.Id -> ' + accTest.Id);
        return accTest.Id;
          
    } 
    
    
    
}