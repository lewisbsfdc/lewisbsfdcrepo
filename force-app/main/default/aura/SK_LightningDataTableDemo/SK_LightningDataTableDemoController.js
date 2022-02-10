({
    doInit : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label:'Action',type:  'button',typeAttributes:
             {iconName: 'utility:view',label: 'View Record',name: 'viewRecord', disabled: false,value: 'viewBtn'}
            },
            {label: 'Account Name', fieldName: 'Name', type: 'text', sortable: true},
            {label: 'Industry', fieldName: 'Industry', type: 'text',sortable: true},
            {label: 'Type', fieldName: 'Type', type: 'Text',sortable: true}
        ]);
        
        var params ={searchString:component.get('v.accSearchValue')};
        helper.callToServer(
            component,
            "c.searchAccountsSOQL",
            function(response)
            {   
                console.log('apex response :'+JSON.stringify(response));
                component.set("v.acctList",response);
            }, 
            params
        );
        
    },
    updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },
    handleRowAction :function(cmp,event,helper){
        //action gives which action performed
        var action = event.getParam('action');
        //row gives complete row information
        var row = event.getParam('row');
        console.log('*****row:'+JSON.stringify(row));
        console.log(JSON.stringify(action));
        alert('You have selected View Action for '+row.Name+'(id='+row.Id+')');
    },
    
    handleClick : function (cmp, event, helper){
      helper.showToast(cmp,event,helper, 'error handle', 'Error', 'error');  
    },
    
    handleClick1 : function (cmp, event, helper){
      helper.showToast(cmp,event,helper, 'success handle', 'Successful', 'success');  
    },
    
     handleClick2 : function (cmp, event, helper){
      //helper.showToast(cmp,event,helper, 'success handle', 'Successful', 'success');  
   
        var toastEvent = $A.get("e.force:showToast");
        console.log("toastEvent", toastEvent);
        toastEvent.setParams({
            "title" : 'title',
            "message" : 'msg',
            "type": 'success'
        });
        console.log("toastEvent.setParams", toastEvent.setParams);
        toastEvent.fire();
    
       }, 
    
})