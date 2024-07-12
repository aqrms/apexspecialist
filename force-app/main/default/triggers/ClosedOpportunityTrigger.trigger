trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> taskList = new List<Task>();
    List<Opportunity> toProcess = new List<Opportunity>();
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            for (Opportunity o : Trigger.New) {
                if (o.StageName == 'Closed Won') {
                   toProcess.add(o);
                }
            }
        }
        when AFTER_UPDATE {
            toprocess = [SELECT Id
                          FROM Opportunity
                          WHERE Id in :Trigger.New AND
                         StageName = 'Closed Won'
                         ];
        }
    }
        
        for (Opportunity o : toProcess) {
            taskList.add(new Task(Subject = 'Follow Up Test Task',
                                 WhatId = o.Id));
        }
        if (taskList.size() > 0) {
            insert taskList;
        }
}