@RestResource(urlMapping='/restExample')
global with sharing class RestExample  {
/*
    @HttpPost 
  global static String testRest() {
     System.debug('inTestRest ');
    // System.debug('CASE TYPE: '+caseType);
     return 'Success';
   }

    @HttpGet
    global static Lead show() {

        Lead obj;

        return obj;

    }

    @HttpPost
    global static Lead create() {

        Lead obj = new Lead();
        obj.FirstName = 'First';

        return obj;

    }
*/

    @HttpPost
    global static Map<String, String> createMap(String x) {

        Map<String, String>  map1 = new Map<String,String>();
        map1.put('A', '1');
        map1.put('B', '2');
        map1.put('C', x);



        return map1;

    }

    @HttpGet
    global static Lead show() {

        //Lead obj; 
        //obj.FirstName = 'First';

        Lead obj = [Select FirstName, LastName, Id from Lead Limit 1];


        return obj;

    }

/*
    @HttpPut
    global static Lead updateObject() {

        Lead obj;

        return obj;

    }

    @HttpDelete
    global static void remove() {

    }
*/
}