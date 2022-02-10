public class GetMetadataValues {
    @AuraEnabled
    public static List<String> getMetadata( String ControllingField) {
        // Perform isAccessible() checks here
        List<String> lstValues = new List<String> ();
        for (Dependent_Picklist__mdt picklistValue : [SELECT Controlling_Field_API_Name__c, Controlling_Field_Value__c 
                                                      from Dependent_Picklist__mdt 
                                                      where Controlling_Field_API_Name__c = :ControllingField] ) {
            system.debug(picklistValue);
            if (! lstValues.contains(picklistValue.Controlling_Field_Value__c) ){
                lstValues.add(picklistValue.Controlling_Field_Value__c);
            }
        }
        return lstValues;
    }


    @AuraEnabled
    public static Map<String, List<String>> getMetadata( String ControllingField, String DependentField) {
        // Perform isAccessible() checks here
        //
        system.debug('ControllingField -> ' + ControllingField + '; DependentField -> '+ DependentField);
        Map<String, List<String>> mapValues = new Map<String, List<String>> ();
        for (Dependent_Picklist__mdt picklistValue : [SELECT Controlling_Field_API_Name__c, Controlling_Field_Value__c,  
                                                      		Dependent_Field_API_Name__c, Dependent_Field_Value__c
                                                      from Dependent_Picklist__mdt 
                                                      where Controlling_Field_API_Name__c = :ControllingField
                                                      and Dependent_Field_API_Name__c = :DependentField]
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