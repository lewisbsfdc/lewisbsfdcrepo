({
    handleMouseEnter : function(component, event, helper) {
        console.log('HandleMouseEnter');
        var popover = component.find("popover1");
        $A.util.removeClass(popover,'slds-hide');
    },
    
    
   handleMouseLeave : function(component, event, helper) {
        console.log('HandleMouseLeave');
        var popover = component.find("popover1");
        $A.util.addClass(popover,'slds-hide'); 
    }
    //make a mouse leave handler here
})