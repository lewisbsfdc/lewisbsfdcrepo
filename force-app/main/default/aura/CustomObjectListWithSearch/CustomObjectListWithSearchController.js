({
    doInit : function(component, event, helper) {

        var processDate = component.get("v.processDate");
        console.log('processDate -> ' + processDate);
        if (processDate == null || processDate == undefined){
            console.log('inside if processDate -> ' + processDate);
            var todayDate = new Date();
            var today = todayDate.getFullYear() + "-" + (todayDate.getMonth()+1) + "-" + todayDate.getDate();
            component.set("v.processDate", today);
        }


        component.set('v.mycolumns', [
            // {label:'Action',type:  'button',typeAttributes:
            //  {iconName: 'utility:view',label: 'View Record',name: 'viewRecord', disabled: false,value: 'viewBtn'}
            // },
            // {label: 'Account Name', fieldName: 'Name', type: 'text', sortable: true},
            // {label: 'Industry', fieldName: 'Industry', type: 'text',sortable: true},
            // {label: 'Type', fieldName: 'Type', type: 'Text',sortable: true}
            {label: 'Name', fieldName: 'Name', type: 'text', sortable: true},
            {label: 'Dollar', fieldName: 'Number_Filter__c', type: 'number',sortable: true},
            {label: 'Checkbox', fieldName: 'checkbox__c', type: 'text',sortable: true},
            {label: 'Description', fieldName: 'Description__c', type: 'text',sortable: true},
            {label: 'Name', fieldName: 'Account_Name__c', type: 'text',sortable: true},
            {label: 'Account', fieldName: 'Hyperlink__c', type: 'url',sortable: false , 
                typeAttributes: {label:'Account'} }
               // typeAttributes: { label: { fieldName: 'AccountName' }, target: '_blank' }},

        ]);
        
//https://lb-trailhead-dev-ed.lightning.force.com/lightning/r/Account/0014100001GvfMCAAZ/view


        var params ={searchString:component.get('v.searchValue')};
        helper.callToServer(
            component,
            "c.searchCustomObjectSOQL",
            function(response)
            {   
                console.log('apex response :'+JSON.stringify(response));
                component.set("v.objList",response);
            }, 
            params
        );
        
    },
    updateColumnSorting: function (cmp, event, helper) {
        cmp.set("v.selectedRowsList", []);

        var ltngCmp = cmp.find("dataTable");
        if(ltngCmp){
               ltngCmp.set("v.selectedRows", []);            
        }
        var data = cmp.get("v.objList");
        //var selectedRows = event.getParam('selectedRowsList');
        var selectedRowsList = cmp.get("v.selectedRowsList");
        console.log('selectedRowsList', selectedRowsList);
        cmp.set("v.selectedRowsList", []);


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


    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        // console.log ('selectedRows', selectedRows);
        //var selectedRowsList = cmp.get("v.selectedRowsList");
        //cmp.set(v.selectedRows,[]);


     


        //console.log ('selectedRowsList', selectedRowsList);
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },

    handleClick: function (cmp, event) {

    },


})