public class AddTopic {
    public static Boolean newTopic(sObject obj, String inTopic){
        Topic aTopic = [Select Id  from Topic where Name = :inTopic Limit 1];
        
        TopicAssignment ta = new TopicAssignment();
        ta.EntityId = obj.id;
        //ta.NetworkId = aTopic.NetworkId;
        ta.TopicId = aTopic.id;
        insert ta;

        return true;
        
    }

}