({
	   doInit : function(component, event, helper) {
        console.log('doInit');
        // Prepare the action to load Leads record
        var action = component.get("c.getEmailTemplatesNames");
        //action.setParams({"LHId": component.get("v.recordId")});
        console.log('call to Controller1');
        var leadId = component.get("v.leadId");
        console.log('LeadId - > ' + leadId);
          
       action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.lstRecords", response.getReturnValue());
                //console.log(response.getReturnValue() );
                console.log('DonInit - > ' + state);

            } else {
                console.log('Problem getting Leads, response state: ' + state);
            }
        });
        $A.enqueueAction(action);  
          
    },

    
    
    HandleNextClick : function(component, event, helper) {
        
        console.log("OfferDetailsController.HandleNextClick: entered");

        
        // Fire Component (Bubbling) event to ask the OfferLetterSPA LC (Parent) to hide this child LC and unhide the Template child LC:
                
        var cmpEvent = component.getEvent("bubblingEvent");
        console.log('cmpEvent: ' + cmpEvent);
        
        cmpEvent.setParams({"ComponentAction" : 'OfferDetails_Next' });
        
        cmpEvent.fire(); 
        
        
        
        
        // Get the values from the form
        var n1 = component.find("language").get("v.value");
        console.log("language entered: " + n1);
        
        
        var t1 = component.find("templateSelect").get("v.value");
        console.log("Template Id selected: " + t1);
        //component.get("v.recordId")
        var recId = component.get("v.leadId");
        console.log("Lead Record Id: " + recId);
        
        // Store values on this LC Attributes:
      
        component.set("v.enteredLanguage", n1);
        component.set("v.selectedTemplateId", t1);
        component.set("v.leadId", recId);
        
        
        helper.createOfferAndNavigate(component);
        
        
        
        
        console.log("OfferDetailsController.HandleNextClick: exit");

    }
})