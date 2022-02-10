public with sharing class CampaingSearchAndList {
    public List<Campaign> campaignList  {get;set;}
    public String sortExp  {get;set;}
    public String[] countries {get;set;}

    public String filterName  {get;set;}
    public String filterType {get;set;}
    public String filterStatus {get;set;}
    public String sortDirection = 'ASC'; 
    
	public CampaingSearchAndList() {
        system.debug('CampaingSearchAndList constructor');
        queryCampaign();
		
	}
    public void applyFilters() {
        queryCampaign();
    }
    public void clearSearchFields() {
        filterName = null;
        filterType = null;
        filterStatus = null;
        queryCampaign();
    }
    public void ViewData() {
    }
    public String getSortDirection() 
    {    
        //if not column is selected     
        if (sortExpression == null || sortExpression == '')      
            return 'ASC';    
        else     
            return sortDirection; 
    } 
    
    public void setSortDirection(String value) 
    {     
        sortDirection = value; 
    } 
    public String sortExpression   
    {     
        get     
        {        
            return sortExp;     
        }     
        set     
        {       
            //if the column is clicked on then switch between Ascending and Descending modes       
            if (value == sortExp)         
                sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';       
            else         
                sortDirection = 'ASC'; 
            
            sortExp = value;     
        }   
    } 

    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Planned','Planned')); 
        options.add(new SelectOption('Completed','Completed')); 
        options.add(new SelectOption('Other','Other')); 
        return options; 
    }  

    public List<SelectOption> getACH() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('ACH 1','ACH 1'));
            options.add(new SelectOption('ACH 2','ACH 2'));
            options.add(new SelectOption('ACH 3','ACH 3'));
            return options;
        } 

    public PageReference test() {
            return null;
    }


    public void queryCampaign() {


        String selectClause = 'SELECT Name, Type, Status ';
        string fromClause = 'FROM Campaign ';
        string whereClause = null;
        List<Campaign> lstCamp = new List<Campaign>();


      if (filterStatus != null && filterStatus.Trim() != '') {
            //whereClause +=  termToSearch.Parse('Name', String.escapeSingleQuotes(filterFirmName)) + ') ';
            whereClause = 'where Status Like \'%' + filterStatus + '%\'';
        }
        else {
            whereClause = ' ';
        }

      if (filterName != null && filterName.Trim() != '' && whereClause == ' ') {
            //whereClause +=  termToSearch.Parse('Name', String.escapeSingleQuotes(filterFirmName)) + ') ';
            whereClause = 'where Name Like \'%' + filterName + '%\'';
        }
        else {
            //whereClause = ' ';
        }

      if (filterType != null && filterType.Trim() != '' && whereClause == ' ') {
            //whereClause +=  termToSearch.Parse('Name', String.escapeSingleQuotes(filterFirmName)) + ') ';
            whereClause = 'where Type Like \'%' + filterType + '%\'';
        }
        else {
            //whereClause = ' ';
        }




        campaignList = new List<Campaign>();
        String soqlQuery = selectClause + fromClause +
                    whereClause ;
                  // + 'ORDER BY  NULLS LAST';
       // soqlQuery += ' LIMIT ' + list_size + ' OFFSET ' + counter;  
        System.debug('\n soqlQuery: ' + soqlQuery);

        try {
            lstCamp = database.query(soqlQuery); 
        } catch(System.QueryException e) {
            //OFI_ErrorHandler.sendEmailErrMessage('CampaignListCallDown360 OFI_SearchTerm Query Error', '', 'Bad Query: ' + soqlQuery + '\r\n\r\n' + e.getMessage() + '\r\n\r\n' + e.getStackTraceString(), true, true);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.info, 'One or more filter values are invalid. Filter not applied.'));
        }
        system.debug('lstCamp - > ' + lstCamp);
        campaignList.clear();
        for (Campaign camp : lstCamp){
            campaignList.add(camp);
        }
        system.debug('lstCamp - > ' + lstCamp);

    }
     
}