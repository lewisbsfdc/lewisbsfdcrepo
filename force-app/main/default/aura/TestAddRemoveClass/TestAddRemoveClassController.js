({

    hideSection1: function(cmp, event) {
        var cmpTarget = cmp.find('section1');
        $A.util.addClass(cmpTarget, 'slds-hide');
    },
    
    showSection1: function(cmp, event) {
        var cmpTarget = cmp.find('section1');
        $A.util.removeClass(cmpTarget, 'slds-hide');
    },
    hideSection2: function(cmp, event) {
        var cmpTarget = cmp.find('section2');
        $A.util.addClass(cmpTarget, 'slds-hide');
    },
    
    showSection2: function(cmp, event) {
        var cmpTarget = cmp.find('section2');
        $A.util.removeClass(cmpTarget, 'slds-hide');
    },
    hideSection3: function(cmp, event) {
        var cmpTarget = cmp.find('section3');
        $A.util.addClass(cmpTarget, 'slds-hide');
    },
    
    showSection3: function(cmp, event) {
        var cmpTarget = cmp.find('section3');
        $A.util.removeClass(cmpTarget, 'slds-hide');
    },

    showSection1a: function(cmp, event) {
        var cmpTarget1 = cmp.find('section1');
        var cmpTarget3 = cmp.find('section3');
        $A.util.addClass(cmpTarget3, 'slds-hide');
        $A.util.removeClass(cmpTarget1, 'slds-hide');

    },
    showSection2a: function(cmp, event) {
        var cmpTarget1 = cmp.find('section1');
        var cmpTarget2 = cmp.find('section2');
        $A.util.addClass(cmpTarget1, 'slds-hide');
        $A.util.removeClass(cmpTarget2, 'slds-hide');
        var i;
        //console.log('cmp.get(v.selectedOptions)', cmp.get('v.selectedOptions'));
        var selectOptions = cmp.get('v.selectedOptions'); 
        for (i=0; i < selectOptions.length; i++){
            var cmpTarget = cmp.find(selectOptions[i]);
            $A.util.removeClass(cmpTarget, 'slds-hide');
            
        }
    },
    showSection3a: function(cmp, event) {
        var cmpTarget3 = cmp.find('section3');
        var cmpTarget2 = cmp.find('section2');
        $A.util.addClass(cmpTarget2, 'slds-hide');
        $A.util.removeClass(cmpTarget3, 'slds-hide');
        var i;
        var selectOptions = cmp.get('v.selectedOptions');
        for (i=0; i < selectOptions.length; i++){
            var strSection = 'sec3' + selectOptions[i];
            var cmpTarget = cmp.find(strSection);
            $A.util.removeClass(cmpTarget, 'slds-hide');
            //console.log('selectOptions[i]', selectOptions[i]);
            
        } 
    },

    saveRecord: function (component, event, helper) {
        console.log('saveRecord');
		var ret;

        var flObj = ({'sobjectType':'Fuzzy_Lead__c','Color__c': component.get("{!v.textStatus}"),
                      'Color_Picklist__c' : component.get("{!v.lstPlace}") }) ;
        console.log('flObj', flObj);

		var action1 = component.get("c.saveFuzzyLead");  
        action1.setParams({
        "c": flObj
       });
        action1.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state--'+state);            
            if (component.isValid() && state === "SUCCESS") {
                ret  = response.getReturnValue();
                component.set("v.fuzzyLead", response.getReturnValue());
                helper.navigateTo(ret);
            }
            else {
				console.log('Problem Fuzzy Lead, response state: ' + state);
            }
        });
        $A.enqueueAction(action1);          
       
    },
    
    handleCheckboxChange: function (component, event) {
		component.set('v.selectedOptions', event.getParam("value"));
    },
    
    handleTarAudRoleChange: function (component, event) {
		component.set('v.lstTar', event.getParam("value"));
		console.log('TAR', event.getParam("value"))
    },
    
    handleLanguageChange: function (component, event) {
		component.set('v.lstLang', event.getParam("value"));
		console.log('Lang', event.getParam("value"))
    },
    
    handlePlacementChange: function (component, event) {
		//component.set('v.lstPlace', event.getParam("value"));
        var lstPlace = event.getParam("value");
        var holdList;
        var i;       
        for (i=0; i < lstPlace.length; i++){
            console.log('lstPlace[i]' , lstPlace[i]);
            if (i==0) {
                 holdList = lstPlace[i];
            }
            else {
            	holdList= holdList + ', ' + lstPlace[i];
            }
        }  
        component.set('v.lstPlace', holdList);
		console.log('Place', event.getParam("value"))
        console.log('v.lstPlace', component.get("{!v.lstPlace}"));
    }


})