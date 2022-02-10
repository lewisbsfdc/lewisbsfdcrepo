({
	doInit : function(component, event, helper) {
        var recordId = component.get("{!v.recordId}");
        //setTimeout(function () {$A.get('e.force:closeQuickAction').fire();}, 1500);
		console.log("doInit -> ", recordId);
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Record Updated",
            "message": "SAP Id is " + recordId + "."
        });
        resultsToast.fire();
        // Close the action panel
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        console.log('fire close quick action');
        $A.get("e.force:closeQuickAction").fire();
        dismissActionPanel.fire();
        
    
    },

	handleClick : function(component, event, helper) {
       var SAPId;
       console.log('handleclick');
        var recordId = component.get("{!v.recordId}"); 
        console.log('recordId ->', recordId);
        var action = component.get("c.createSAPId");

		action.setParams({
			accId : recordId
		})  

        console.log('before callback ->');
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('setCallBack state', state );
        	if (state === "SUCCESS") {
                console.log("SUCCESS");
                SAPId = response.getReturnValue();
                console.log('SAPId -> ', SAPId);
                

        	}
            else {
                console.log('setCallBack else state', state );
            }
        	
        });
        $A.enqueueAction(action);
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
        			"title": "Record Updated",
        			"message": "SAP Id has been created."
        });
       	resultsToast.fire();
        console.log('after callback ->', SAPId);

		var dismissActionPanel = $A.get("e.force:closeQuickAction");
      	dismissActionPanel.fire();
        
    },    
})