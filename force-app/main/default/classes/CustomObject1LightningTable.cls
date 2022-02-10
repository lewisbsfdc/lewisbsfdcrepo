public with sharing class CustomObject1LightningTable extends LightningDataTableVirtual{
	public CustomObject1LightningTable() {
		
	}
    @auraEnabled
    public static DataTableResponse getCustomRecords (String strObjectName, String strFieldSetName, String searchField, String searchValue){
        return getRecords(strObjectName, strFieldSetName, searchField, searchValue);
    }
}