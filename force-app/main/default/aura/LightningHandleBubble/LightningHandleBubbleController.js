({

    doInit : function(component, event, helper) {
        console.log('doInit');

        
    } ,
	handleBubbleEvent : function(component, event, helper) {
        console.log('handleBubbleEvent');
        var item = event.getParam("item");
        console.log('item', item);
		
	}
})