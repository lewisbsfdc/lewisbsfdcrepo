({
	doInit : function(component, event, helper) {
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
            { label: 'CHINA', value: 'CHINA' }
        ]; 
        
        component.set('v.parentOptions', pVals);
        component.set('v.dependentPicklist', dPick);
      
        component.set('v.lstRegions', vListRegions);
        component.set('v.oCountryOptions', oCountries);
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