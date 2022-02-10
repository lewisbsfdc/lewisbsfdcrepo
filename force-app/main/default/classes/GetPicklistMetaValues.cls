public class GetPicklistMetaValues {
    @AuraEnabled
    public static List <String> getMetadata(String ObjectName, String ControllingField) {
        // Perform isAccessible() checks here
        system.debug('1 ObjectName -> ' + ObjectName + 'ControllingField -> ' + ControllingField );
        List<String> lstValues = new List<String> ();
        for (Dependent_Picklist__mdt picklistValue : [SELECT Controlling_Field_API_Name__c, Controlling_Field_Value__c 
                                                      from Dependent_Picklist__mdt 
                                                      where Controlling_Field_API_Name__c = :ControllingField 
                                                      and Object_Name_For_Dependent_Picklist__c = :ObjectName] ) {
            system.debug(picklistValue);
            if (! lstValues.contains(picklistValue.Controlling_Field_Value__c) ){
                if (! lstValues.contains(picklistValue.Controlling_Field_Value__c)) {              
                	lstValues.add(picklistValue.Controlling_Field_Value__c);
                }
            }
        }
        return lstValues;
    }


    @AuraEnabled
    public static Map<String, List<String>> getMetadataDependent(String ObjectName, String ControllingField, String DependentField) {
        // Perform isAccessible() checks here
        //
        system.debug('2 ObjectName -> ' + ObjectName + 'ControllingField -> ' + ControllingField + '; DependentField -> '+ DependentField);
        Map<String, List<String>> mapValues = new Map<String, List<String>> ();
        for (Dependent_Picklist__mdt picklistValue : [SELECT Controlling_Field_API_Name__c, Controlling_Field_Value__c,  
                                                      		Dependent_Field_API_Name__c, Dependent_Field_Value__c
                                                      from Dependent_Picklist__mdt 
                                                      where Controlling_Field_API_Name__c = :ControllingField
                                                      and Dependent_Field_API_Name__c = :DependentField 
                                                      and Object_Name_For_Dependent_Picklist__c = :ObjectName]
            		) // for loop starts 
        	{
            system.debug(picklistValue);
            if ( mapValues.get(picklistValue.Controlling_Field_Value__c) == null){
                mapValues.put(picklistValue.Controlling_Field_Value__c, new List<String>{picklistValue.Dependent_Field_Value__c});                                                  
            }
            else {
                mapValues.get(picklistValue.Controlling_Field_Value__c).add(picklistValue.Dependent_Field_Value__c);                                              
            }
        } // for loop ends
        return mapValues;
    }
}