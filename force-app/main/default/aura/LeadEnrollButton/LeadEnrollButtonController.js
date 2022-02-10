({
    doInit : function(component, event, helper) {
        component.set("v.isDisabled", false);
   
        var action = component.get("c.getLeadStatus");
        console.log('doInit');
            action.setParams({
        leadId : component.get("v.recordId")
        });
        //console.log("helper led -> " + led);
        action.setCallback(this, function(response) {
        if (response.getState() === "SUCCESS") {
            var ledStatus = response.getReturnValue();
            if (ledStatus == "Disenrolled" || ledStatus == "Not Applicable"){
                component.set("v.isDisabled", true);
            }
            console.log('retvalue -> ' + ledStatus);
        } else if (a.getState() === "ERROR") {
            $A.log("Errors", a.getError());
            console.log("helper ERROR");
        }
        }); 
        $A.enqueueAction(action);
        
  

        var recertDates = ["11/01/2017", "12/01/2017", "01/01/2018","02/01/2018", "03/01/2018", "04/01/2018"];
        console.log(recertDates);  
       component.set("v.lstRecertDate", recertDates);
        var reasons = ["Happy", "Grumpy", "Sneezy","Bashful", "Sleepy", "Dopey", "Doc"];
        console.log(reasons);  
       component.set("v.lstReason", reasons);
     
        },
    HandleContinue : function(component, event, helper) {
        console.log("HandContinue");
    }
})