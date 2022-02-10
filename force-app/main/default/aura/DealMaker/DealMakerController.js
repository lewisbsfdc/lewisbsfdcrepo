({
	doinit : function(component, event, helper) {
		console.log("doinit");
		var action = component.get("c.getOpportunity");
		var oppId = "0064100000APdn1AAD";
		action.setParams({
			//oppId : component.get("v.recordId"),
			oppId : oppId,
		})
		console.log("record Id -> " + component.get("v.recordId") );
		console.log("oppId ->  " + oppId );
		action.setCallback(this, function(response){
            console.log(response.getState());
            if (response.getState() === "SUCCESS") {
                //var viewAll = component.get("c.viewAll");
                console.log("After View all");
                var mapOpp = response.getReturnValue();
                component.set("v.mapOpp", mapOpp);
                var numberOfRecs;
                if (mapOpp == undefined || mapOpp == null){
                    numberOfRecs = 0;
                } 
                else {
                    var listOpp;
                    for (var singlekey in mapOpp) {
                        console.log('singlekey -> ' , singlekey);
                        console.log('mapOpp[singlekey] -> ' , mapOpp[singlekey]);
                        //console.log("ParentiD -> " + mapCase[singlekey]);
                        listOpp = mapOpp[singlekey];
                    }
                    // Set the all list of keys on component attribute, which name is lstKey and type is list.     
                    numberOfRecs = listOpp.length;
                    component.set('v.lstOpp', listOpp);           
                    component.set("v.numberOfChildren", numberOfRecs);
                    // var viewAll = component.find("viewAll");   
                    // $A.util.removeClass(viewAll, 'slds-hide');

                    //var viewAll = component.find("viewAll");
                    //$A.util.removeClass(viewAll, 'slds-hide');
                }
            }
            else { 
                $A.log("Errors", response.getError());
                console.log("helper ERROR");
                var errMsg = response.getError();
                component.set("v.errMessage", errMsg);
                //component.set("v.showCaseList", false);
               
            }

            //console.log("case -> " + cse);
        });
		$A.enqueueAction(action);


	}
})