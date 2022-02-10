({
	logMapElements : function(cmp, ret) {       
        var objControl, strControl, strDepend; 
        var lstObjControl = [];
        var objControlDepend = {};
        var objDepend = {};
        var objControlDepends = {};
		// console.log('logMapElements ret', ret);
         for (var controller in ret){
             strControl = '{"label":"'   + controller  + '" , "value":"'  + controller + '"}';
			 objControl = JSON.parse(strControl);	
             lstObjControl.push(objControl);
             objControlDepend =  JSON.parse('{"' + controller + '": []}'); 
            // console.log('objControlDepend', objControlDepend);                            
             for (var i=0; i < ret[controller].length; i++  ){
                 strDepend = '{"label":"'   + ret[controller][i]  + '" , "value":"'  + ret[controller][i] + '"}';
                 objDepend = JSON.parse(strDepend);
                 objControlDepend[controller].push(objDepend);
             }
             objControlDepends = Object.assign(objControlDepends, objControlDepend);
        }
       // console.log('objControlDepends', objControlDepends);
       // console.log('lstObjControl', lstObjControl);
        cmp.set('v.lstControlling', lstObjControl);
        cmp.set('v.oDependentOptions', objControlDepends);
	}
})