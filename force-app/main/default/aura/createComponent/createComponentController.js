/*createComponentController.js*/
({
    doInit : function(cmp) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "findableAuraId",
                "label": "Press Me",
                "onclick": cmp.getReference("c.handlePress")
            },
            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = cmp.get("v.body");
                    body.push(newButton);
                    cmp.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }

        );
        cmp.set("v.typeName", "fuzzy_lead__c");
        cmp.set("v.fsName", "colorfs");
        
 
        // $A.createComponent(
        //     "lightning:input",
        //     {
        //         value: "Red",
        //         label: "Label",
        //         type: "Text"
        //     },
        //     function(newLabel, status, errorMessage){
        //         //Add the new button to the body array
        //         if (status === "SUCCESS") {
        //             console.log('1');
        //             var label = cmp.get("v.label");
        //                                 console.log('2', label);
        //             label.push(newLabel);
        //                                 console.log('3');
        //             cmp.set("v.label", label);
        //         }
        //         else if (status === "INCOMPLETE") {
        //             console.log("No response from server or client is offline.")
        //             // Show offline error
        //         }
        //         else if (status === "ERROR") {
        //             console.log("Error: " + errorMessage);
        //             // Show error message
        //         }
        //     }
            
        // );
        
        
        
    },

    handlePress : function(cmp) {
        // Find the button by the aura:id value
        console.log("button: " + cmp.find("findableAuraId"));
        console.log("button pressed");
        var label = cmp.get("v.label");
        console.log('label ' , label[0]);
        var va = label[0].get("v.value");
        console.log('va ' , va);
    },
    
  

    doSelectFieldSet: function(component, event, helper) {
        //var fsName = event.target.getAttribute("name");
        console.log("doSelectField");
        var fsName = "Color";
        helper.getFields(component, fsName);
        //helper.getFields(component);
    },
    
})