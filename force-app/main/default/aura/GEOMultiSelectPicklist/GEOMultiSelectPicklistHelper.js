({
	logMapElements : function(cmp, ret) {
        
        
         /*
        var innerObj = JSON.parse('{"label":"AN" , "value":"AN"}');
        var innerObj1 = JSON.parse('{"label":"AF" , "value":"AF"}');
        console.log('innerObj',innerObj);
        var outerObj = JSON.parse('{"ANT": []}'); 
        console.log('outerObj',outerObj);
        var y = "ANT";
        console.log('outerObj[y]',outerObj[y]);
        outerObj[y].push(innerObj);
        outerObj[y].push(innerObj1);
        console.log('outerObj after pushs',outerObj); 
        var oCountries = Object.assign(oCountries, outerObj);
        */       
        var objRegion, strRegion, strCountry; 
        var lstObjRegion = [];
        var objRegionCountry = {};
        var objCountry = {};
        var objRegionsCountries = {};
		 console.log('logMapElements ret', ret);
         for (var region in ret){
             strRegion = '{"label":"'   + region  + '" , "value":"'  + region + '"}';
			 var objRegion = JSON.parse(strRegion);	
             lstObjRegion.push(objRegion);
             objRegionCountry =  JSON.parse('{"' + region + '": []}'); 
            // console.log('objRegionCountry', objRegionCountry);                            
             for (var i=0; i < ret[region].length; i++  ){
                 strCountry = '{"label":"'   + ret[region][i]  + '" , "value":"'  + ret[region][i] + '"}';
                 objCountry = JSON.parse(strCountry);
                 objRegionCountry[region].push(objCountry);
                 //console.log('i', i);
                 //console.log('country',ret[region][i]);
                 //console.log('strCountry',strCountry);
                 //console.log('objRegionCountry',objRegionCountry);
                 //var json = '{"result":true, "count":42}'; 
             }
             objRegionsCountries = Object.assign(objRegionsCountries, objRegionCountry);
        }
        console.log('objRegionsCountries', objRegionsCountries);
        console.log('lstObjRegion', lstObjRegion);
        cmp.set('v.lstRegions', lstObjRegion);
        cmp.set('v.oCountryOptions', objRegionsCountries);
	}
})