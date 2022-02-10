public class PageController {
    public ComponentData theData {get;set;}

    public pageController() {
        theData = new ComponentData();
        theData.theInput = 'PageControllerInput';
        system.debug('pageController');
    }
    
    public PageController getPageCont(){
        return this;
    }
}