({

      doInit : function(component, event, helper) {
		console.log('doInit');
        // Prepare the action to load Leads record
        var action = component.get("c.getLeads");
        action.setParams({"LHId": component.get("v.recordId")});
        console.log('call to Controller16');
          
       action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.leads", response.getReturnValue());
                console.log(state);
            } else {
				console.log('Problem getting Leads, response state: ' + state);
            }
        });
        $A.enqueueAction(action);  
          
	}, 
    
    callServer : function(component, event, helper) {
		console.log('callServer Component Called');
 
        var leads = component.get("v.leads");
        for (var i = 0; i < leads.length; i++) {
            console.log ('Leads -> ' + leads[i].led.Name + ' ' + leads[i].led.Email + ' ' + leads[i].sendEmail);
        }

        console.log(component);
        console.log(event);
	},

	sendEmail : function(component, event, helper) {
		console.log('Send Email');
        console.log(component);
        console.log(event);
	},
  
    CloseWindow : function(component, event, helper) {
        console.log('CloseWindow');
        var LHId = component.get("v.recordId");
        console.log(LHId);
        //this.jjj(LHId);
        //this.navigateToSObject(LHId.toString());


        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": LHId,
            "isredirect" : false
        });

        navEvt.fire();


    },

    navigateToSObject : function(recordId) {
        console.log('naviagateToSObject');
 
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "isredirect" : false
        });

        navEvt.fire();
    },

    jjj : function (x){
        console.log('jjj' +  x);
        console.log ('jjj');
    },

    sendEmailHelper : function(component, event, helper) {
        console.log('Send Email Helper 1'); 
        helper.sendEmailHelper(component,event);

    },

 	toggleConvertButton : function(component, event, helper) {
		console.log('toggleConvertButton');
        console.log(component);
        console.log(event);
	}   
})