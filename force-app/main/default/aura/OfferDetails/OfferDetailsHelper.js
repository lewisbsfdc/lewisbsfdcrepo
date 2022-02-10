({
    createOfferAndNavigate : function(cmp) {
      
        console.log("OfferDetailsHelper.createOfferAndNavigate: entered");
       
        var cId = cmp.get("v.leadId");
        console.log("leadId ID: " + cId);
        
        var language = cmp.get("v.enteredLanguage");
        console.log("language: " + language);
        
        
        var templateId = cmp.get("v.selectedTemplateId");
        console.log("TemplateId: " + templateId);
      
       // var action = cmp.get("c.upsertOfferRecord");
        
        //action.setParams({ 
        //    offerId : templateId,
        //    candidateID : cId,
        //    annualSalary : salary,
        //    annualBonus : bonus
        //});

        // Create a callback that is executed after 
        // the server-side action returns
        //action.setCallback(this, function(response) {
        //    var state = response.getState();
            // This callback doesn’t reference cmp. If it did,
            // you should run an isValid() check
            //if (cmp.isValid() && state === "SUCCESS") {
        //    if (state === "SUCCESS") {
        //        cmp.set("v.offerId", response.getReturnValue());
                
        //        var offerIdVal = cmp.get("v.offerId");

          //      console.log("Offer ID Value: " + offerIdVal);    
        
        
               
                
                
               var lstRecs = cmp.get("v.lstRecords");
                     
                //Pass the values grabbed from this LC Form + Candidate ID to the next child LC via Lightning Events:
                var appEvent = $A.get("e.c:CandidateDetailEvent");

                appEvent.setParams({ "candidateID" : cmp.get("v.candidateId"),
                                     "enteredLanguage" : cmp.get("v.enteredLanguage"),
                                     //"enteredBonus" : cmp.get("v.enteredBonus"),
                                     "selectedTemplateId" : cmp.get("v.selectedTemplateId"),
                                    "leadId": cmp.get("v.leadId"),
                                    //"email": lstRecs[0].candidateEmail,
                                    "LCWhoFired": 'OfferDetails.cmp'
                                   });
                
               
                
                
                appEvent.fire();

                
              console.log('appevent fired');
                
            //}
            //else if (cmp.isValid() && state === "INCOMPLETE") {
            //else if (state === "INCOMPLETE") {
                // do something
            //}
            //else if (cmp.isValid() && state === "ERROR") {
            //else if (state === "ERROR") {
            //    var errors = response.getError();
            //    if (errors) {
            //        if (errors[0] && errors[0].message) {
            //            console.log("Error message: " + 
            //                     errors[0].message);
            //        }
            //    } else {
            //        console.log("Unknown error");
            //    }
            //}
        //});

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
       // $A.enqueueAction(action);
        
        console.log("OfferDetailsHelper.createOffer: exit");
        
    }
})