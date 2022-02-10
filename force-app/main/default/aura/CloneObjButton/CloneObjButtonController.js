({
	 doInit: function(component, event, helper) {
    console.log('doinit');
      helper.fetchListOfRecordTypes(component,  event, helper);
      //call the helper function with pass [component, Controller field and Dependent Field] Api name 
     // alert('Hi');
    // $A.get("e.force:closeQuickAction").fire();
      //helper.queryOpp(component, event, helper);
         //helper.queryFieldSet(component, event, helper);
         
     // $A.get("e.force:closeQuickAction").fire();

   },
    
    createRecord: function(component, event, helper) {
        console.log('Create Record');
        helper.queryFieldSet(component, event, helper);
    },
    closeModal: function(component, event, helper) {
        var closeEvent = $A.get("e.force:closeQuickAction");
        if(closeEvent){
        	closeEvent.fire();
        } 
        else{
            alert('force:closeQuickAction event is not supported in this Ligthning Context');
        }
    },    
})