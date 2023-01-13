public class LeadProcessor implements
    Database.Batchable<sObject>, Database.Stateful {
	// instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
            'SELECT ID, Name from Lead'
        );
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope){

        for (Lead l : scope) {
           l.LeadSource = 'Dreamforce';
           recordsProcessed = recordsProcessed + 1;
        }
        update scope;
    }
        
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
    
}