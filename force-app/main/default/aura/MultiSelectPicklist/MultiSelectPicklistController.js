({
	doInit : function(component, event, helper) {
		console.log('doInit');
        var ret; 
        var cmpControlling = component.find('dependPicklist');
        var cmpDepend = component.find('controllingPicklist');
        var cmpObjName = component.get('v.ObjectName');
        var cmpDField = component.get('v.DependentField');
        var cmpCField = component.get('v.ControllingField');
        console.log ('cmpObjName', cmpObjName);
        console.log ('cmpCField', cmpCField);
        console.log ('cmpDField', cmpDField);
       // Prepare the action to load Leads record
        var action;
		if (cmpDField != 'None') {
            console.log('2 list boxes');
            action =  component.get("c.getMetadataDependent"); 
        	action.setParams({'ObjectName': component.get('v.ObjectName'),
                         'ControllingField': component.get('v.ControllingField'),
                         'DependentField': component.get('v.DependentField')});
        }
        else {
             console.log('1 list boxes');
            action =  component.get("c.getMetadata"); 
 			action.setParams({'ObjectName': component.get('v.ObjectName'),
                         'ControllingField': component.get('v.ControllingField')});           
        }
        if (cmpDField != 'None') {   
            $A.util.removeClass(cmpDepend, 'slds-size_1-of-1');
            $A.util.addClass(cmpDepend, 'slds-size_1-of-2');
            $A.util.removeClass(cmpControlling, 'slds-hide');
        }
       //$A.util.addClass(cmpTarget3, 'slds-hide');
       //$A.util.removeClass(cmpTarget1, 'slds-hide');        
       action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                //component.set("v.leads", response.getReturnValue());
                ret = response.getReturnValue();
                console.log('typeof ret', typeof ret)
                helper.logMapElements(component, ret);
            } else {
				console.log('Problem getting Picklist Values, response state: ' + state);
            }
        });
        $A.enqueueAction(action); 


	},
    pickChange : function(component, event, helper) {
        var parentValue = component.find('parentPicklist').get('v.value');
        component.set('v.dependentOptions', component.get('v.dependentPicklist')[parentValue]);
        
        
    },
    handleChange : function(component, event, helper) {
        console.log('handleChange');
        var vParentValue = event.getParam("value");
        var vList = [];
        var i, j;
        for (i=0; i < vParentValue.length; i++ ){
            for (j=0; j < component.get('v.oDependentOptions')[vParentValue[i]].length; j++ ){
                vList.push(component.get('v.oDependentOptions')[vParentValue[i]][j]);
            }    

            
        }
        component.set('v.lstDepends', vList);
        
    }, 
    handleDependChange : function(component, event, helper) {
        console.log('handleCountryChange');
        var selectedOptionsList = event.getParam("value");
		component.set('v.selectedDepends', selectedOptionsList);
        
    },
    
    handleButtonClick : function(component, event, helper) {
        console.log('handleButtonClick; selectedCountries->', component.get('v.selectedDepends') );
        
    },    
    
})