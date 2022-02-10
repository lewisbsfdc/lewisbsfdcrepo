({
	doInit : function(component, event, helper) {
		console.log('CloneFuzzyLead');
        console.log('recordId', component.get("v.recordId"));
        console.log('newObject', component.get("v.newObject"));
 /*       
        component.find("objectRecordCreator").getNewRecord(
            "Fuzzy_Lead__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newObject");
                console.log('rec ->' , rec);
                var error = component.get("v.newObjectError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        );
        */
	}
})