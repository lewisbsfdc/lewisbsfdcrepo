public class LeadHouseholdAssignmentManager {
	//public list<User> ORSAgent = new list<User>();
	public list<User> lstORSAgent {get; set;}
	public map<Integer, User> mapORSAgent {get; set;}
	public User u {get; set;}
	public Integer idx{get; set;}
	public LeadHouseholdAssignmentManager() {
		lstORSAgent = [Select Id,Name, 	Language__c, 	Line_Of_Business__c
					from User
					Limit 10];

		mapORSAgent = new Map<Integer,User>();
		Integer count = 1;
		idx = 0;
		Integer i;
		do {
		    i = Math.floor(Math.random() *  lstORSAgent.size() ).intValue();
			//System.debug(i);
			if (idx + 1 > lstORSAgent.size()) {
				system.debug('Break');
				break;
			}
	 		if (mapORSAgent.get(i) == null) {
				mapORSAgent.put(i, lstORSAgent.get(idx++));
			} 		    
			count++;

		} while (count < 100 || mapORSAgent.size() <= lstORSAgent.size());
		system.debug('count -> ' + count);
		idx = 0;		
	}

	public list<User> getORSAgent(){
		return lstORSAgent;
	}

	public User getNextAgent() {
		return mapORSAgent.get(getNextIndex());
	}

	public User getPrevAgent() {
		return mapORSAgent.get(getPrevIndex());
	}

	public User getNextAgent(String language) {
		Integer mapIndex;
		for (Integer i = 0 ; i < mapORSAgent.size() ; i++  ) {
			
			mapIndex = getNextIndex();
			//system.debug('mapIndex -> ' + mapIndex);
			//system.debug(mapORSAgent.get(mapIndex).Language__c);
			if (mapORSAgent.get(mapIndex).Language__c != null) {
				List<String> lstLanguage = mapORSAgent.get(mapIndex).Language__c.split(';');
				for (String lang : lstLanguage){
					if (lang == language) {
						return mapORSAgent.get(mapIndex);
						break;
					}
				}			
			} 
		}
		return null;
	}

	private Integer getNextIndex(){
		idx++;
		if ( idx  >=  mapORSAgent.size()) {
			idx = 0;
		}
		return idx;
	}

	private Integer getPrevIndex(){
		idx--;
		if ( idx  <  0) {
			idx = mapORSAgent.size() - 1;
		}
		return idx;
	}

}