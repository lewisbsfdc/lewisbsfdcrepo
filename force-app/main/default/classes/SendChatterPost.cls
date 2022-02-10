public class SendChatterPost {
	@AuraEnabled
    public static Boolean  CreateChatterPost (string oppId){
        
    
        List<FeedItem> lstFeedItems = new List<FeedItem>(); 
        FeedItem fitem = new FeedItem();
        //'0F91K000000cS7oSAE'
        fitem.ParentId = '0F91K000000cS7oSAE';
        fitem.LinkUrl = '/' + oppId; //This is the url to take the user to the activity
        fitem.Title = 'View'; //This is the title that displays for the LinkUrl
        fitem.Body =  '  New order has been Created for Opportunity: Opportunity Account 1; Salesforce Id:  ' + oppId + ';  Quote Id: a0v1K00000FHNQHQA5';
        //lstFeedItems.add(fitem);
        
        insert fitem;
    
    //Save the FeedItems all at once.
      //  if (lstFeedItems.size() > 0) {
      //  Database.insert(lstFeedItems,false); //notice the false value. This will allow some to fail if Chatter isn't available on that object
    
        //}
        return true;
    }    
    
}