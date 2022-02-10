({
    handleComponentEvent: function (component,event) {
        var num = component.get("v.num");
        component.set("v.num", num + 1);
        console.log("I am in container component");
    }
})