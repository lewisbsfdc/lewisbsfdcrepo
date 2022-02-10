({
	doInit : function(component, event, helper) {
		console.log('doInit');
        var obj = {};
        var objCountry = {};
        var objArray = [];
        var ret; 
       // Prepare the action to load Leads record
        var action = component.get("c.getMetadata");
        console.log('component.get(v.ControllingField)',component.get('v.ControllingField'))
        action.setParams({'ControllingField': component.get('v.ControllingField'),
                         'DependentField': component.get('v.DependentField')});
        //console.log('call to getMetadata');
          
       action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                //component.set("v.leads", response.getReturnValue());
                ret = response.getReturnValue();
                helper.logMapElements(component, ret);
            } else {
				console.log('Problem getting Picklist Values, response state: ' + state);
            }
        });
        $A.enqueueAction(action); 
  /*      
          var oCountries = {
            "NAMER" : [            
                {label:"US" , value:"US"},
            	{label:"CA" , value:"CA"}
                    ],
             "JAPAN" : [            
                {label:"JP" , value:"JP"}
                    ],          
              "CHINA" : [            
                {label:"CN" , value:"CN"},
                {label:"TW" , value:"TW"},
            	{label:"HK" , value:"HK"}
                    ],
            "EMEA" : [            
                {label:"UK" , value:"UK"},
            	{label:"FR" , value:"FR"}
                    ]
        } ; 
*/
        //var txt = '{"name":"John", "age":30, "city":"New York"}';
        //var txt = '{"label":"AN" , "value":"AN"}';
		//var objX = JSON.parse(txt);
        //console.log('objX',objX);
        //
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
        */
        //var outerObj.ANT = Object.assign(outerObj.ANT, innerObj);
        //console.log('outerObj',outerObj);
        //var json =  {"ANT" : [            
        //        {label:"AN" , value:"AN"}
        //]}; //{label:"US" , value:"US"},{label:"CA" , value:"CA"}
        // var json = '{"result":true, "count":42}';
       // var oCountries = Object.assign(oCountries, outerObj);
        //var jsonParse = JSON.parse(json);
        //console.log('oCountries', oCountries);
        //console.log('jsonParse', jsonParse);
        //console.log('jsonParse.NAMER', jsonParse.NAMER);
        //console.log('dPick',dPick);

        var pVals= [
            {text:"USA" , value:"USA"},
            {text:"Japan" , value:"Japan"},
            {text:"Canada" , value:"Canada"}
        ];
        var dPick = {
            "USA" : [            
                {text:"New York" , value:"New York"},
            	{text:"Seattle" , value:"Seattle"}
                    ],
            "Japan" : [            
                {text:"Tokyo" , value:"Tokyo"},
            	{text:"Osaka" , value:"Osaka"}
                    ],
            "Canada" : [            
                {text:"Montreal" , value:"Montreal"},
            	{text:"Toronto" , value:"Toronto"}
                    ]
        } ;
     
        //console.log('oCountries',oCountries);
        var langauges = [
            { label: 'English', value: 'en' },
            { label: 'German', value: 'de' },
            { label: 'Spanish', value: 'es' },
            { label: 'French', value: 'fr' }
        ];
        var vListRegions = [
            { label: 'NAMER', value: 'NAMER' },
            { label: 'JAPAN', value: 'JAPAN' },
            { label: 'EMEA', value: 'EMEA' },
            { label: 'ANT', value: 'ANT' },
            { label: 'CHINA', value: 'CHINA' }

        ]; 
        
        component.set('v.parentOptions', pVals);
        component.set('v.dependentPicklist', dPick);
      
        //component.set('v.lstRegions', vListRegions);
        //component.set('v.oCountryOptions', oCountries);
       // console.log('oCountries', oCountries);
    //    console.log('NAMER', oCountries['NAMER'] );
       // console.log('oCountryOptions', component.get('v.oCountryOptions'))  ;
	},
    pickChange : function(component, event, helper) {
        var parentValue = component.find('parentPicklist').get('v.value');
        component.set('v.dependentOptions', component.get('v.dependentPicklist')[parentValue]);
        
        
    },
    handleChange : function(component, event, helper) {
        console.log('handleChange');
        var vParentValue = event.getParam("value");
        console.log('vParentValue.length', vParentValue.length);
        var vList = [];
        var i, j;
        for (i=0; i < vParentValue.length; i++ ){
            //vList.push(component.get('v.oCountryOptions')[vParentValue[0]]);
            //console.log ('vParentValue[i]' , vParentValue[i]);
            console.log ('oCountryOptions', component.get('v.oCountryOptions')[vParentValue[i]])
            //console.log ('i' , i);
            for (j=0; j < component.get('v.oCountryOptions')[vParentValue[i]].length; j++ ){
                console.log ('i' , i);
                console.log('country', component.get('v.oCountryOptions')[vParentValue[i]][j]);
                vList.push(component.get('v.oCountryOptions')[vParentValue[i]][j]);
            }    
            //vList.push(component.get('v.oCountryOptions')[vParentValue[i]]);
            
        }
        console.log('vList', vList);
        //console.log('oCountryOptions', component.get('v.oCountryOptions'))
        //console.log('vParentValue', vParentValue );
        //component.set('v.lstCountries', component.get('v.oCountryOptions')[vParentValue]);
        component.set('v.lstCountries', vList);
        
    }, 
    handleCountryChange : function(component, event, helper) {
        console.log('handleCountryChange');
        var selectedOptionsList = event.getParam("value");
		component.set('v.selectedCountries', selectedOptionsList);
        
    },
    
    handleButtonClick : function(component, event, helper) {
        console.log('handleButtonClick; selectedCountries->', component.get('v.selectedCountries') );
        
    },    
    
})