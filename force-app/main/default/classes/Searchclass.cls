public with sharing class Searchclass {
  
   public list <Account> acc {get;set;}
   public list<Contact> con{get;set;}
   public list<Opportunity> opty{get;set;}
   public list<String> nameSearch{get;set;}
   public list<returnWrapper> returnAddresses{get;set;}
   public string searchstring {get;set;} 
   public string value1 {get;set;} 
   public String apiKey {get;set;} 
   
     public Searchclass() {
      system.debug('Searchclass');
      apiKey = 'AIzaSyBJpqM1gX8A3tzRBb13op5ci9tiZOJZWeY';
   } 
    
   //public Searchclass(ApexPages.StandardController controller) {
     
   //}  
   public void search(){  
     if(searchstring != null && searchstring != '' ){  
     string acQuery = 'select Id, Name, Email from Contact where Name like \'%'+searchstring+'%\'  Limit 5';
     string searchquery='select Name, Phone from Account where Name like \'%'+searchstring+'%\'  Limit 10';  
     string searchquery1='select Name, Phone from Contact where Name like \'%'+searchstring+'%\'  Limit 10';
     string searchquery2='select Name, StageName from Opportunity where Name like \'%'+searchstring+'%\'  Limit 10';
     acc= Database.query(searchquery); 
         system.debug('acc = ' + acc);
     con= Database.query(searchquery1); 
                 system.debug('con = ' + con);
     opty= Database.query(searchquery2); 
         system.debug('opty = ' + opty);
     }
  }

@RemoteAction
public static List<returnWrapper> getContactName (String searchString){
    system.debug('searchString -> '  + searchString);
    string acQuery = 'select Id, Name, Email from Contact where Name like \''+searchstring+'%\' Order by FirstName Limit 5';
    List<Contact> listCon= Database.query(acQuery); 
    system.debug('con = ' + listCon);
    List<returnWrapper> lstRet = new List<returnWrapper>();
    for (Contact con : listCon){
        returnWrapper retWrap = new returnWrapper();
        retWrap.Name = con.Name;
        retWrap.Id = con.Id;
        retWrap.Email = con.Email;
        lstRet.add(retWrap);
    }

    //  List<String> lstRet = new List<String> 
    //{
    //  '1234 Alpha Street Seattle, WA 98101',
    //  '123 Argon Road Seattle, WA 98102',
    //  '12 Aspen Terrace Seattle, WA 98103',
    //  'Searchclass',
    //  'C',
    //  'C++',
    //  'Clojure',
    //  'COBOL',
    //  'ColdFusion',
    //  'Erlang',
    //  'Fortran',
    //  'Groovy',
    //  'Haskell',
    //  'Java',
    //  'JavaScript',
    //  'Lisp',
    //  'Perl',
    //  'PHP',
    //  'Python',
    //  'Ruby',
    //  'Scala',
    //  'Scheme'
    //};
    return lstRet;
}


@RemoteAction
public static String createSearchLIst (String lati, String longi){
  system.debug('createSearchLIst lati -> ' + lati + '; longi -> ' + longi);
  if (lati != null && longi != null) {
    string qWhere = 'where DISTANCE(Location__c, GEOLOCATION(' + lati + ',' + longi + '), \'mi\')  < 3000 ';
    string qOrderBy = 'Order by FirstName Limit 50000';
    string acQuery = 'select Id, Name, Email from Contact ' + qWhere + qOrderBy;   
    system.debug('acQuery -> ' + acQuery) ;
    List<Contact> listCon= Database.query(acQuery); 
    List<returnWrapper> returnAddresses = new List<returnWrapper>();
    for (Contact con : listCon){
        returnWrapper retWrap = new returnWrapper();
        retWrap.Name = con.Name;
        retWrap.Id = con.Id;
        retWrap.Email = con.Email;
        returnAddresses.add(retWrap);
    }

    system.debug('returnAddresses -> ' + returnAddresses);
    return 'Success';
  }
  else {
    return 'Error';
  }
}


public class returnWrapper {
  String Id;
  String Name;
  String Email;
}

}