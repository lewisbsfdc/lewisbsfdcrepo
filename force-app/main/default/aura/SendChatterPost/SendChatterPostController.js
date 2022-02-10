({
	doInit : function(component, event, helper) {
    
        var recordId = component.get("{!v.recordId}");
		console.log("doInit -> ", recordId);

   },  
 handleClick : function(component, event, helper) {
        var recordId = component.get("{!v.recordId}");
		console.log("handleClick -> ", recordId);

        var action = component.get("c.CreateChatterPost");
		action.setParams({
			oppId : recordId
		})
        console.log('before callback ->');
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('setCallBack state', state );
        	if (state === "SUCCESS") {
                var ret = response.getReturnValue();
                console.log('ret -> ', ret);
        	}
            else {
                console.log('setCallBack else state', state );
            }
        	$A.get("e.force:closeQuickAction").fire();
        });
       	$A.enqueueAction(action);       
        
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
        			"title": "SAP Order",
        			"message": "Order has been created."
        });
       	resultsToast.fire();
        
        
        // Close the action panel
        console.log('fire close quick action');
        
        
    
    },

})