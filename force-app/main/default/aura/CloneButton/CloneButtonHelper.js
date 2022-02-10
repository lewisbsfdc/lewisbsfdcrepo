({
    queryOpp: function(component,  event, helper) {
      var recordId = component.get("v.recordId");
        if(recordId!=undefined){
        
        
        //alert(recordId);
        var action = component.get("c.getDetailsFromOpp");
        action.setParams({
            recordId: recordId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
           
            if (state === "SUCCESS") {
                var opp = response.getReturnValue();
                component.set("v.oppName", opp.Name); 
                component.set("v.typePick", opp.OrderNumber__c);
                component.set("v.campaign", opp.CampaignId);
               
                helper.createOppRecord(component, event, helper);
              
            }
           
        });
        
        $A.enqueueAction(action);
        }
    },
	 createOppRecord : function (component, event, helper) {
       var name=  component.get("v.oppName"); 
       var picklist = component.get("v.typePick"); 
        var campaign=  component.get("v.campaign");
        // alert(picklist);
       //  alert(campaign);
    var createOpportunityEvent = $A.get("e.force:createRecord");
	createOpportunityEvent.setParams({
    "entityApiName": "Opportunity",
    "defaultFieldValues": {
        'Name' : name + '1',
        'Type' : 'Existing Customer - Upgrade',
        'OrderNumber__c' : picklist,
        'CampaignId' : campaign
    	}
	});
	createOpportunityEvent.fire();
    },
})