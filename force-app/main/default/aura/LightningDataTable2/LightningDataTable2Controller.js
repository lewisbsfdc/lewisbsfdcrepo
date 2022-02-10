({
    doInit : function(component, event, helper) {		                
        helper.getDataHelper(component, event);
    },
    handleClick : function(component, event, helper) {		                
        console.log('handleClick');
    }, 
    handleComponentEvent: function (component,event) {
        console.log("handleComponentEvent");
    },   
    onRowSelection: function (component,event) {

        console.log("onRowSelection");
        var lstMyData = component.get("{!v.myData}");
        var selectedRows = event.getParam('selectedRows');
        for (var i = 0; i < selectedRows.length; i++) {
            console.log('i', i);
            console.log('selectedRows', selectedRows);
        }
        var cmpEvent = component.getEvent("compEvent");
        cmpEvent.setParams({"item" : "From LDT2"})
        cmpEvent.fire();
        console.log('after event');
    },   
        // fireComponentEvent: function (component) {
        //     console.log('fireComponentEvent');
        //     var cmpEvent = component.getEvent("compEvent");
        //     //var cmpEvent = $A.get("e.c:LightningDataTableEvent")
        //     console.log('cmpEvent', cmpEvent);
        //     cmpEvent.fire();
        // },
})