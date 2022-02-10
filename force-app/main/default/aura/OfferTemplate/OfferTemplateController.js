({
    handleApplicationEvent : function(component, event, helper) {
        
        console.log("OfferTemplateController.handleApplicationEvent: entered");
        
        var params = event.getParams();
        
        
        
        component.set("v.recordId", params.candidateID);
        component.set("v.enteredSalary", params.enteredSalary);
        component.set("v.enteredBonus", params.enteredBonus);
        component.set("v.selectedTemplateId", params.selectedTemplateId);
        component.set("v.offerId", params.offerId);
        component.set("v.email", params.email);
        
        if (params.offerText) {
            component.set("v.templateVal", params.offerText);
            console.log("text back = " + component.get("v.templateVal"));
        }
        
        if (params.offerSubject) {
            component.set("v.templateSubjectVal", params.offerSubject);
            console.log("subject back = " + component.get("v.templateSubjectVal"));
        }

        console.log("candidateID = " + component.get("v.recordId"));
        console.log("enteredSalary = " + component.get("v.enteredSalary"));
        console.log("enteredBonus = " + component.get("v.enteredBonus"));
        console.log("selectedTemplateId = " + component.get("v.selectedTemplateId"));   
        console.log("OfferId = " + component.get("v.offerId"));
        console.log("Email = " + component.get("v.email"));  
        
        // Only call the Apex Server controller if we have the candidateId, templateId and offerId provided by the Lightning Event
        if (component.get("v.recordId") && component.get("v.selectedTemplateId") && component.get("v.offerId"))
        {
            helper.getTemplate(component);
        }
        
        

        console.log("OfferTemplateController.handleApplicationEvent: exit");
        
    },
    
    goBack : function(component, event, helper) {
        
        console.log("OfferTemplateController.goBack: entered");

        // Fire Component (Bubbling) event to ask the OfferLetterSPA LC (Parent) to go back to previous child LC:
        
        var cmpEvent = component.getEvent("bubblingEvent");
        console.log('cmpEvent: ' + cmpEvent);
        
        cmpEvent.setParams({"ComponentAction" : 'OfferTemplate_Back' });

        cmpEvent.fire();
        
        
        console.log("OfferTemplateController.goBack: exit");
    }
})