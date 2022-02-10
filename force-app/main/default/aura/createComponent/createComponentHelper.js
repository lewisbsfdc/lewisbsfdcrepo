({
  getTypeNames: function(component, event) {
        var action = component.get("c.getTypeNames");
        action.setParams({})
        action.setCallback(this, function(a) {
            var types = a.getReturnValue();
            component.set("v.types", types);
        });
        $A.enqueueAction(action);        
    },
    
     getFieldSetNames: function(component, typeName) {
        var action = component.get("c.getFieldSetNames");
        action.setParams({typeName: typeName});
        action.setCallback(this, function(a) {
            var fsNames = a.getReturnValue();
            component.set("v.fsNames", fsNames);
        });
        $A.enqueueAction(action);        
    },
   
    getFields: function(component) {
        console.log('getFields');
        var action = component.get("c.getFields");
        var self = this;
        var typeName = component.get("v.typeName");
        var fsName = component.get("v.fsName");
        console.log ('fsName ' , fsName);
        console.log ('TypeName ' , typeName);
        //action.setParams({typeName: "fuzzy_lead__c", fsName: "colorfs"});
        action.setParams({typeName: typeName, fsName: fsName});
        action.setCallback(this, function(a) {
            var fields = a.getReturnValue();  
            console.log('fields', fields);
            component.set("v.fields", fields);
            self.createForm(component, fields);
        });
        $A.enqueueAction(action);
        //this.createForm(component, self.fields);        
    }, 
 createForm: function(component, fields) {
        console.log('createForm', fields);
        var field = null;
        var cmp = null;
        var def = null;
        var config = null;
        var form1 = component.get("v.form");

        var self = this;
        console.log('self ', self);

        // Clear any existing components in the form facet
        console.log('form  - > ' ,component.get("v.form") )
        component.set("v.form", []);
        //var facet = component.getValue("v.form");
        var facet = component.get("v.form");
        var values = [];
        for (var i = 0; i < fields.length; i++) {
            field = fields[i];
            // Copy the config, note that this type of copy may not work on all browsers!
            config = JSON.parse(JSON.stringify(this.configMap[field.type.toLowerCase()]));
            // Add attributes if needed
            config.attributes = config.attributes || {};
            // Add attributes.values if needed
            config.attributes.values = config.attributes.values || {};

            // Set the required and label attributes
            config.attributes.values.required = field.required;
            config.attributes.values.label = field.label;

            // Add the value for each field as a name/value            
            values.push({name: field.fieldPath, value: undefined});

            // Add the component to the facet and configure it
            // console.log('addComponent called comp' , component);
            // console.log('facet' , facet);
            // console.log('config' , config);
            // console.log('field.fieldPath' , field.fieldPath);
            self.addComponent(component, facet, config, field.fieldPath);
        }
        component.set("v.values", values);

    },   
    configMap: {
        "anytype": { componentDef: "markup://ui:inputText" },
        "base64": { componentDef: "markup://ui:inputText" },
        "boolean": {componentDef: "markup://ui:inputCheckbox" },
        "combobox": { componentDef: "markup://ui:inputText" },
        "currency": { componentDef: "markup://ui:inputText" },
        "datacategorygroupreference": { componentDef: "markup://ui:inputText" },
        "date": { componentDef: "markup://ui:inputDate" },
        "datetime": { componentDef: "markup://ui:inputDateTime" },
        "double": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0.00"} } },
        "email": { componentDef: "markup://ui:inputEmail" },
        "encryptedstring": { componentDef: "markup://ui:inputText" },
        "id": { componentDef: "markup://ui:inputText" },
        "integer": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0"} } },
        "multipicklist": { componentDef: "markup://ui:inputText" },
        "percent": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0"} } },
        "picklist": { componentDef: "markup://ui:inputText" },
        "reference": { componentDef: "markup://ui:inputText" },
        "string": { componentDef: "markup://ui:inputText" },
        "textarea": { componentDef: "markup://ui:inputText" },
        "time": { componentDef: "markup://ui:inputDateTime", attributes: { values: { format: "h:mm a"} } },
        "url": { componentDef: "markup://ui:inputText" }
    },
    // Adds the component via newComponentAsync and sets the value handler
    addComponent: function(cmp, facet, config, fieldPath) {

         console.log('Facet' , facet);
         console.log('config' , config);
         console.log('fieldPath' , fieldPath);
         console.log('component' , cmp);
        console.log('xxxxxxxxxxxxxxxxxxxxxxxx');

        $A.createComponent(
            "lightning:input",
            {
                value: undefined,
           //     label: "config.attributes.values.label",
                label: config.attributes.values.label,
                type: "Text"
            },
            function(newLabel, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    console.log('1');
                    var label = cmp.get("v.form");
                                        console.log('2', label);
                    label.push(newLabel);
                                        console.log('3');
                    cmp.set("v.form", label);
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


        /*
        $A.createComponent(
            "lightning:input", {
                value: "v.value",
                label: "Label",
                type: "Text"
            },
            $A.getCallback(function(newCmp, status, error) {
                     var values = component.get("v.form");
                     console.log('values', values);
                     facet.push(newCmp);
                     //body.push(newCmp);    
                    for (var i = 0; i < values.length; i++) {
                        if (values[i].name === fieldPath) {
                            console.log('FieldPage -> ', fieldPath );
                            //values[i].value = event.getParams().value;
                            values[i].value = i;
                        }
                    }                                              
                     component.set("v.values", values);
                     //component.set("v.form", values);
                     console.log('lightning Input');
            })
        );
        */
    },
})