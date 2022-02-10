public with sharing class Lead_Household_Handler {
	public Lead_Household_Handler() {

		
	}
    public void getORS_Agent() {
        List <ORS_Agent> lstORS_Agent = new List<ORS_Agent>();
        for (User u : [Select Id from User]) {

            ORS_Agent ORS = new ORS_Agent();
            ORS.Id = u.Id;

        }


    }


    public class ORS_Agent{
        public String Id  {get; set;}
        public String Language {get; set;}
        public String Region  {get; set;}
    }

}