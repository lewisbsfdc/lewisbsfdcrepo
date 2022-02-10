({
loadLead : function(component) {

    action.setParams({
        leadId : component.get("v.recordId")
    });
	console.log("helper led -> " + led);
    action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
            component.set("v.lead", response.getReturnValue());
            console.log('retvalue -> ' + response.getReturnValue());
        } else if (a.getState() === "ERROR") {
            $A.log("Errors", a.getError());
            console.log("helper ERROR");
        }
    });
	
    $A.enqueueAction(action);
     
}
})