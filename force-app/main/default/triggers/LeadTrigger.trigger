trigger LeadTrigger on Lead (before insert, after insert, after delete, after undelete) {
	system.debug('Trigger Fired');
    if(Trigger.isInsert)
    {
    	system.debug('Trigger isInsert');
    	if(Trigger.isAfter)
    	{
    		system.debug('LeadHandler Called');
    		LeadHandler.OnAfterInsert(Trigger.new);
    	}
    }

    if(Trigger.isDelete)
    {
        system.debug('Trigger isInsert');
        if(Trigger.isAfter)
        {
            system.debug('LeadHandler Called');
            LeadHandler.OnAfterDelete(Trigger.old);
        }
    }
}