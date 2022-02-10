({
	doInit : function(component, event, helper) {
		console.log("doInit");
	},

	
    handleChange: function (cmp, event, helper) {
   

        var changeValue = event.getParam("value");
        var lstOptions = cmp.get("v.options");
        for (var i = 0; i < lstOptions.length; i++  ) { 	
        	if (lstOptions[i].value == changeValue){
        		helper.removeClass(cmp, changeValue, 'slds-hide');
        	}
        	else {
        		helper.addClass(cmp, lstOptions[i].value, 'slds-hide');
        	}
        }
  
    }
});