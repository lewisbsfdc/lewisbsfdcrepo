public class CompController {

  public ComponentData cData {get;set;}
  public pageController thePageController {get;set;}

  public string searchText {get;set;}
  
    public void CompController(){
      cData = new ComponentData();
      cData.theInput = 'Input';
      cData.theOutput = 'Output';
      system.debug('cdata -> ' + cData );
    }

  public void updateData(){
      
      system.debug('UpdateData cdata before -> ' + cData );
      cData = new ComponentData();
      list<ComponentData> cd = new list<ComponentData>();
      cData.theInput = searchText + '-' + 'a1';
      cData.theOutput = searchText + '-' + 'b1';
      cd.add(cData); 
      system.debug('UpdateData cdata -> ' + cData );
      //thePageController.theData.theInput = searchText + '-' + 'a1';
      //thePageController.theData.theOutput = searchText + '-' + 'b1';


  }

}