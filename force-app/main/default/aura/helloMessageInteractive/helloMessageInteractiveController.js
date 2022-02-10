({
    handleClick: function(component, event, helper) {
        var btnClicked = event.getSource();         // the button
        var btnMessage = btnClicked.get("v.label"); // the button's label
        component.set("v.message", btnMessage);     // update our message
    },
    
    handleClick2: function(component, event, helper) {
    	var newMessage = event.getSource().get("v.label");
    	component.set("v.message", newMessage);
	},

    handleClick3: function(component, event, helper) {
    	component.set("v.message", event.getSource().get("v.label"));
	},
    showToast : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent == null || toastEvent == undefined) {
            console.log("ToastEvent is null" + toastEvent);
        }
        toastEvent.setParams({
            "title": "Success!",
            "type": "info",
            "message": "Show the toast."
        });
        toastEvent.fire();
	},
    
        doInit : function(component, event, helper) {
        var action = component.get("c.getCaseComment");
        console.log('doInit');
        action.setParams({
        	//caseId : component.get("5004100000Jo4kTAAR")
            caseId : "5004100000Jo4kTAAR"
        });
  
        action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
            var listCaseComments = response.getReturnValue();

             component.set("v.listCaseComment", listCaseComments)
     
        } else if (response.getState() === "ERROR") {
            $A.log("Errors", response.getError());
            console.log("ERROR");
            var errMsg = response.getError();
            console.log(errMsg)
            //var messageContainer = component.find("resultMessageContainer");
            //component.set("v.errMessage", errMsg);
            //$A.util.removeClass(messageContainer, 'slds-hide');
        }
        }); 
        $A.enqueueAction(action);
        //helper.loadLOBPicklist(component);
        //helper.loadReason(component);
        //helper.loadRecertDates(component);
        },
})