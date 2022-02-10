({
    doInit : function(component, event, helper) {
        var action = component.get("c.getLead");
        action.setParams({
                leadId: "00Q4100000ZzCzCEAV",
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.lead", response.getReturnValue());
                console.log(response.getReturnValue());
            }
         });
         $A.enqueueAction(action); 
    }     
})