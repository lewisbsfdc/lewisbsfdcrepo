({
    doInit: function(component, event, helper) {
        //console.log('doInit', component.get("v.type"));
        //helper.getFields(component, event);
        //helper.getFieldSetNames(component, event);
    },

    doGetTypeNames: function(component, event, helper) {
        helper.getTypeNames(component, event);
    },

    doSelectType: function(component, event, helper) {
        var type = event.target.getAttribute("name");
        helper.selectType(component, type);
    },

    doSelectFieldSet: function(component, event, helper) {
        var fsName = event.target.getAttribute("name");
        helper.selectFieldSet(component, fsName);
        //helper.getFields(component);
    },

    doSubmit: function(component, event, helper) {
        helper.submitForm(component, event);
    },
    handlePress : function(cmp) {
        // Find the button by the aura:id value
        console.log("button: " + cmp.find("findableAuraId"));
        console.log("button pressed");
    },
})