({
	 doInit: function(component, event, helper) {
      //call the helper function with pass [component, Controller field and Dependent Field] Api name 
     // alert('Hi');
      helper.queryOpp(component, event, helper);
   },
})