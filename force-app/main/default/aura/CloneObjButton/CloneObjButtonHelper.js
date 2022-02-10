({
    queryOpp: function(component,  event, helper) {
     console.log('queryOpp');
      helper.fetchListOfRecordTypes(component,  event, helper);
      var i = 0;
                
        //console.log('key ->', key);
        //console.log('Record Type ->', mapOfRecordTypes[key]);          
     
      var recordId = component.get("v.recordId");
        if(recordId!=undefined){
        
        
        //alert(recordId);
        var action = component.get("c.getDetailsFromCR");
        action.setParams({
            recordId: recordId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
           
            if (state === "SUCCESS") {
                var cr = response.getReturnValue();
                component.set("v.crName", cr.Name); 
                component.set("v.custObj3", cr.Cust_Object_3__c);
                component.set("v.crRecord", cr);
                helper.createCRRecord(component, event, helper);
            }
           
        });
        
        $A.enqueueAction(action);
        }
    },
    
    queryFieldSet: function(component,  event, helper) {
      console.log('queryFieldSet');
      //helper.fetchListOfRecordTypes(component,  event, helper);
      // var selectedRecordTypeName = component.find("recordTypePickList").get("v.value")
      // var i = 0;
                
      //   //console.log('key ->', key);
      //   //console.log('Record Type ->', mapOfRecordTypes[key]);          
     
      // var recordId = component.get("v.recordId");
      //   if(recordId!=undefined){
        
        
      //   //alert(recordId);
      //   var action = component.get("c.getFieldSetMap");
      //   action.setParams({
      //       sObjName: 'Cust_Object_1__c', 
      //       fieldSetName : 'Cust_Obj_1_FS',
      //       recordId: recordId
      //   });
      //   action.setCallback(this, function(response){
      //       var state = response.getState();
      //      console.log('state -> ' + state);
      //       if (state === "SUCCESS") {
      //           var cr = response.getReturnValue(); 
      //           component.set("v.custObj3", cr.Cust_Object_3__c);
      //           component.set("v.crRecord", cr);
      //           helper.createCRRecord(component, event, helper);
      //       }
      //       else {
      //           console.log('Error ->  ' + state);
      //       }
           
      //   });
        
      //   $A.enqueueAction(action);
      //   }
    },

    
	 createCRRecord : function (component, event, helper) {
         console.log('createCRRecord');
  //        var recordTypeId;
  //        console.log('createCRRecord 1');
  //       var selectedRecordTypeName = component.find("recordTypePickList").get("v.value")
  //       var mapRT = component.get("v.mapOfRecordType");
  //       console.log('mapRT -> ', mapRT);
  //       for(var key in mapRT){
  //         if (mapRT[key] == selectedRecordTypeName){
  //         	recordTypeId = key;
  //         }
  //       }
  //       console.log('recordTypeId 2 -> ', recordTypeId);
 	// 	$A.get("e.force:closeQuickAction").fire();
  //       var cr=  component.get("v.crRecord");
  //       // alert(picklist);
  //      //  alert(campaign);
  //   	var createCREvent = $A.get("e.force:createRecord");
		// createCREvent.setParams({
  //       "entityApiName": "Cust_Object_2__c",
  //       "recordTypeId" : recordTypeId,
  //       "defaultFieldValues": {
  //           'Cust_Object_1__c' : component.get("v.recordId"),
  //           'Cust_Object_3__c' : cr.Cust_Object_3__c,

  //           }
  //       });

		// console.log('createCREvent.fire -> before');
		// createCREvent.fire();
  //       console.log('createCREvent.fire -> after');
  //   $A.get("e.force:closeQuickAction").fire();
    },

    fetchListOfRecordTypes: function(component, event, helper) {
        console.log('fetchListOfRecordTypes');
        var action = component.get("c.fetchRecordTypeValues")
        //pass the object name here for which you want
        //to fetch record types
        action.setParams({
            "objectName" : "Cust_Object_2__c"
        });
        action.setCallback(this, function(response) {
            var mapOfRecordTypes = response.getReturnValue();
            component.set("v.mapOfRecordType", mapOfRecordTypes);
            var recordTypeList = [];
            //Creating recordTypeList from retrieved Map
            for(var key in mapOfRecordTypes){
                recordTypeList.push(mapOfRecordTypes[key]);
                console.log('key ->', key);
                console.log('Record Type ->', mapOfRecordTypes[key]);
                
            }

            if(recordTypeList.length == 0){//Object does not have any record types

                //Close Quick Action Modal here

                //helper.closeModal();
                //Calling CreateRecord modal here without providing recordTypeId
                //helper.showCreateRecordModal(component, "", "Contact");
            } else{
            component.set("v.lstOfRecordType", recordTypeList);
            }
            
        });

        $A.enqueueAction(action);
    },



})