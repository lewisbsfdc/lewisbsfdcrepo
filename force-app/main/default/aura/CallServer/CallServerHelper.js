({
	sendEmailHelper : function(component, event, helper) {
		console.log('Send Email Helper 2');
        var action = component.get("c.sendMassEmail");
        var leadWrapper = component.get("v.leads");
        action.setParams({"lstLeadWrapper": JSON.stringify(leadWrapper)});
        console.log('call to Controller a -> ' + leadWrapper);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                //component.set("v.leads", response.getReturnValue());
                console.log('Helper state -> ' + state);
                var ret = response.getReturnValue();
                console.log(ret);  
                console.log('after Response');
            } else {
				console.log('Problem send Email Leads, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
	}
})