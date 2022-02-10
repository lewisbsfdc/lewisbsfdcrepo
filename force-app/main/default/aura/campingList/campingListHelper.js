({
    
    validateItemForm: function(component) {
        // Simplistic error checking
        var validItem = true;
        /*
        // Name must not be blank
        var nameField = component.find("expname");
        var expname = nameField.get("v.value");
        if ($A.util.isEmpty(expname)){
            validExpense = false;
            nameField.set("v.errors", [{message:"Expense name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
    
        // Amount must be set, must be a positive number
        var amtField = component.find("amount");
        var amt = amtField.get("v.value");
        if ($A.util.isEmpty(amt) || isNaN(amt) || (amt <= 0.0)){
            validExpense = false;
            amtField.set("v.errors", [{message:"Enter an expense amount."}]);
        }
        else {
            // If the amount looks good, unset any errors...
            amtField.set("v.errors", null);
        }
        */
        return(validItem);
    },
    
    createItem: function(component, newItem) {
        var action = component.get("c.saveItem");

        alert(JSON.stringify(newItem));
        action.setParams({"camping_Item": newItem});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "ERROR") {
                var errors = response.getError();
                if (errors && errors[0]) {
                    console.log(errors[0]);
                }
                else {
                    console.log("Unknown error");
                }
            }            
            else if (component.isValid() && state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
        });
        $A.enqueueAction(action);
    }
})