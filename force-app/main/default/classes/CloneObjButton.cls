public class CloneObjButton {
  @AuraEnabled  
    public static Cust_Object_1__c getDetailsFromCR(string recordId){
       Cust_Object_1__c cr = [select Id,Name, Cust_Object_3__c
        from Cust_Object_1__c Where Id = :recordId limit 1];
       return cr ;
    }
    
@AuraEnabled        
    public static Map<Id, String> fetchRecordTypeValues(String objectName){
        Map<Id, String> recordtypemap;
        List<Schema.RecordTypeInfo> recordtypes = Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfos();    
        recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master' && rt.getName().trim() != '')
            recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return recordtypemap;
    }   

@AuraEnabled
    public static Map<String, String> getFieldSetMap(String recordId, String sObjName, String fieldSetName){
        system.debug('recordId->' + recordId + '; sObjName-> ' + sObjName +'; fieldSetName ->' + fieldSetName  );
        // Use Schema methods to get field set based on Object name and Field Set name provided
        Map<String, Schema.SObjectType> gdMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType sObjType = gdMap.get(sObjName);
        Schema.DescribeSObjectResult sObjResult = sObjType.getDescribe();
        Schema.FieldSet myFieldSet = sObjResult.FieldSets.getMap().get(fieldSetName);
        
        // Get Field Set Members list to use in querying the specific fields to clone
        List<Schema.FieldSetMember>  fieldSetMemberList = myFieldSet.getFields();
        
        // Create SOQL query; Loop through FieldSetMembers to add all desired fields
        String cloneQuery='SELECT ';
        for (Schema.FieldSetMember f : fieldSetMemberList) {
            cloneQuery = cloneQuery + f.getFieldPath() +',';   
        }
        cloneQuery = cloneQuery + 'Id FROM ' + sObjName + ' WHERE Id=:recordId';
        
        // Query database to get field values from the record to be cloned
        SObject recToClone = Database.query(cloneQuery);
        
        // Map field names to field values
        Map<String, String> fieldSetMap = New Map<String, String>();
        for (Schema.FieldSetMember f : fieldSetMemberList) {
            String fieldName = f.getFieldPath();
            String fieldValue = String.valueof(recToClone.get(f.getFieldPath()));
            fieldSetMap.put(fieldName, fieldValue);
        }
        
        /* Add original record's Id to map as Clone_Id__c custom field. This field must be added to the object being used.
		   This is used if child records need to be cloned. Can be referenced in an Insert trigger as parent record */
        fieldSetMap.put('Clone_Id__c', recordId);
        return fieldSetMap;
    }   




}

/*
Language__c, 	Account__c, Campaign_Business_Unit__c, 	Client_Contact__c, Name__c,
       	Audience_Assignee__c, 	Content_Assignee__c, QA_Assignee__c, Coding_Assignee__c,
       	Mailing_Type__c, Catalogue_Type__c, Complexity__c,
       	Proofing_Group__c, Required_of_Links__c, Required_Versions__c, Communication_Type__c,
       	Channel__c, Seed_List__c, Reporting_Instructions__c, Flow_Rate__c, Campaign_Identifier__c,
        From_Address__c, From_Name__c,  Template__c, Subject_Line__c, Pre_Header__c, Disclaimers__c,
  Personalization__c, Personalized_Default_Values__c,   Personalized_Fields__c, Personalized_Instructions__c, Logic_Creative__c,
  File_Name__c,   Table__c, Segmentation_Instructions__c, Additional_Campaign_Instructions__c
*/