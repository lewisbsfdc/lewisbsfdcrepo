public with sharing class TestLabelController {
    public transient String contingentOfferStatement {get; set;}

    public String testString {get; set;}

    public String locale {get; set;}
    private Id applicationId;
	public TestLabelController() {
		
	}

     public PageReference onPageLoad(){

         this.applicationId = ApexPages.currentPage().getParameters().get('appId');
    //     system.debug(applicationId);
testString = applicationId;
         this.contingentOfferStatement = getParsedContingentOfferStatement(this.applicationId);
         //system.debug('contingentOfferStatement -> ' +  contingentOfferStatement);
         return null;
     }
  
     private void setPortalVars(Id applicationId){
         
         List<Contact> applications = [
      SELECT Id, Name from Contact where Id = :applicationId
             ];
     }
    
  private static Map<String, String> getMergeFieldToQueryFieldMapFromStr(String str){
    Map<String, String> mergeFieldToQueryField = new Map<String, String>();

    Pattern regexPattern = Pattern.compile('\\{!([^}]*)\\}');
    Matcher regexMatcher = regexPattern.matcher(str);

    while(regexMatcher.find()){
      String mergeField = regexMatcher.group();
      String queryField = getRelationshipFieldFromMergeField(mergeField);

      mergeFieldToQueryField.put(mergeField, queryField);
    }

    return mergeFieldToQueryField;
  }

  private static String replaceMergeFieldsWithFieldValues(String str, 
                                                          Contact application,
                                                          Map<String, String> mergeFieldToQueryFieldMap){
    Pattern regexPattern = Pattern.compile('\\{!([^}]*)\\}');
    Matcher regexMatcher = regexPattern.matcher(str);

    while(regexMatcher.find()){
      String mergeField = regexMatcher.group();
      String queryField = mergeFieldToQueryFieldMap.get(mergeField);
      String mergeFieldValue = getFieldValueFromFieldName(queryField, application);

      str = str.replace(
        mergeField,
        String.isNotBlank(mergeFieldValue) ? mergeFieldValue : ''
      );
    }

    return str;
  }

      private static String getFieldValueFromFieldName(String relationshipField, 
                                                   Contact application){
    // Split by periods to separate objects and fields, ie: Contact.Friend__r.Name
    List<String> objectLookups = relationshipField.split('\\.');

    // Determine the final field name, and remove it from the objectLookups list
    String finalFieldName = objectLookups.remove(objectLookups.size()-1);

    // Iterate over objectLookups to retrieve the final object
    SObject currentSObject = application;
    for(String objectLookup : objectLookups){
      if(currentSObject == null){
        break;
      }
      currentSObject = currentSObject.getSobject(objectLookup);
    }

    return currentSObject == null ? '' : String.valueOf(currentSObject.get(finalFieldName));
  }
   private static String getRelationshipFieldFromMergeField(String mergeField){
    mergeField = mergeField.removeStart('{!');
    mergeField = mergeField.removeEnd('}');

    return mergeField;
  }   

  private String getParsedContingentOfferStatement(Id applicationId){
    String unMergedOfferStatement = getUnmergedOfferStatement();

    // Extract queryable fields from the merge fields
    Map<String, String> mergeFieldToQueryFieldMap = getMergeFieldToQueryFieldMapFromStr(unMergedOfferStatement);

    // Query the Application including the query fields extracted from the merge fields
    List<String> queryFields = mergeFieldToQueryFieldMap.values();
    Contact application = queryApplicationWithMergeFields(queryFields, applicationId);

    // Build finalized offer statement by replacing the merge fields with their field values
    return replaceMergeFieldsWithFieldValues(unMergedOfferStatement, application, mergeFieldToQueryFieldMap);
  }
  private String getUnmergedOfferStatement(){
    String unMergedOfferStatement = '';

    if(Test.isRunningTest()){
      //unMergedOfferStatement = TEST_UNMERGEDOFFERSTATEMENT;
    }
    else{
      // Locate first label containing contingent offer
     //unMergedOfferStatement = LabelTranslateController.translate('Contingent_Offer_1', this.locale) + '\n';
     unMergedOfferStatement = Label.Contingent_Offer_1 + '\n';

      // Locate and concatenate second label containing contingent offer
    //unMergedOfferStatement += LabelTranslateController.translate('Contingent_Offer_2', this.locale);
    unMergedOfferStatement += Label.Contingent_Offer_2;
    }

    // Replace \n with HTML line breaks
    return unMergedOfferStatement.replace('\n', '<br/>');
  }

  private static Contact queryApplicationWithMergeFields(List<String> queryFieldsList,
                                                                Id applicationId){
    Set<String> queryFieldsSet = new Set<String>{'Id'};
    queryFieldsSet.addAll(queryFieldsList);

    String queryString = 'SELECT '
      + String.join(new List<String>(queryFieldsSet), ',')
      + ' FROM Contact WHERE Id =: applicationId';
    //system.debug('queryString  -> ' + queryString);
    Contact application;
    try{
      application = Database.query(queryString);
      //system.debug('contact -> ' + application);
    }
    catch(Exception e){
        system.debug('Error -> ' + e.getMessage());
      //throw new ApplicationConitngentOfferControllerException(
       // 'Error while executing dynamic query: ' + queryString, e
      //);
    }

    return application;
  }
}