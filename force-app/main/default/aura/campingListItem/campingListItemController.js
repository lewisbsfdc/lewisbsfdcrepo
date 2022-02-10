({
    packItem: function(component, event, helper) {
        //var btnClicked = event.getSource();         // the button
        //var  = component.get("v.P"); // the button's label
        //component.set("v.item.Packed__c", true);     // update our message
       // var item1 = component.get("c.item");
 
        //var btn = event.getSource();
		//btn.set("v.disabled",true);//Disable the button
		//
		//
		var a = component.get("v.item");
        a.Name = 'Item2';
        a.Quantity__c = 20;
        a.Price__c = 200;
        a.Packed__c = true;
        component.set("v.item",a);
        
        var btnClicked = event.getSource();
        btnClicked.set("v.disabled",true);
    }
})