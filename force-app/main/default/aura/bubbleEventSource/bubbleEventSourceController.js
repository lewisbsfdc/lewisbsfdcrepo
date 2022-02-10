({
    fireComponentEvent: function (component) {
        var cmpEvent = component.getEvent("compEvent");
        console.log('cmpEvent', cmpEvent);
        cmpEvent.fire();
    }
})