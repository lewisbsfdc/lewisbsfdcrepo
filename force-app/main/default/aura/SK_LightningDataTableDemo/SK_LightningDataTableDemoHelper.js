({
    callToServer : function(component, method, callback, params) {
    console.log('Calling helper callToServer function to get data');
        var action = component.get(method);
        if(params){
            action.setParams(params);
        }
        console.log('****param to controller:'+JSON.stringify(params));
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                callback.call(this,response.getReturnValue());
            }else if(state === "ERROR"){
                var errors = response.getError();
                console.error(errors);
                alert('Problem with connection. Please try after sometime or contact your system administrator.');
            }
        });
        $A.enqueueAction(action);
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.acctList");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.acctList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    
    showToast : function (cmp, event, helper, msg, title, type){
        console.log("msg", msg);
        console.log("title", title);
        console.log("type", type);
        var toastEvent = $A.get("e.force:showToast");
        console.log("toastEvent", toastEvent);
        toastEvent.setParams({
            "title" : title,
            "message" : msg,
            "type": type
        });
        console.log("toastEvent.setParams", toastEvent.setParams);
        toastEvent.fire();
        
    },
})