public class TestAddRemoveClass {
    @auraenabled
    public static string saveFuzzyLead(Fuzzy_Lead__c c){
        if(c != null)
        {
            insert c;
            system.debug('c-- '+c);
        }
        return c.id;
    }
}