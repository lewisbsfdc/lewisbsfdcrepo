global class AnimalLocator {
    
    public static String getAnimalNameById  (Integer i){
       
        String ret;
        Integer lim, r;
        r= i;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + i);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            // 
            // 
            // Deserializes the JSON string into collections of primitive data types.
            ////Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animal' key as a map            
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            
            
            system.debug ('results -> ' + results);
            system.debug ('animal -> ' + animal);
            //List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            //system.debug(animals);
            //lim = animals.size();
            //
            ret =  animal.get('name').toString(); 
            
       //     for (Object animal: animals) {
     //           System.debug(animal);
    //}
          //  if (i > lim) r = 0;
          //  ret = String.valueOf(animals[r]);
}


        return ret;
/*
*********************
        
        string str;
        string URL='https://th-apex-http-callout.herokuapp.com/animals/'+id;
        
        http http=new http();
        httprequest Req=new httprequest();
        req.setEndpoint(URL);
        req.setMethod('GET');
        httpResponse Response=http.send(req);
        
        system.debug('Response Code: '+response.getStatusCode());
        system.debug('Response Body: '+response.getBody());
        //type ResultType= type.forName('Animals');
        //system.debug('Type: '+ ResultType);
        AnimalLocator obj= new AnimalLocator();
        obj=(AnimalLocator) System.JSON.deserialize(response.getBody(), AnimalLocator.class);
        System.debug('Obj: '+obj.animal.name );
        str=obj.animal.name;
        System.debug('Name: '+str );
        return str;
            
       
         Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String animalName = 'test';        
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animal' key as a map            
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            animalName = animal.get('name').toString();            
            System.debug('Received the following animal:' + animalName);                       
        }
        return animalName;     
   */         
    }

    public class Animal {
		public Integer id;
		public String name;
		public String eats;
		public String says;
	}
    public Animal animal;    
    
    
}