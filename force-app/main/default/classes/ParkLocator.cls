public class ParkLocator {
	public static List<String> country(String country) {
        ParkService.ParksImplPort parkCountry = new ParkService.ParksImplPort();
        return parkCountry.byCountry(country);
      	//return retList;
    }
}