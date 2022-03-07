//Get records to unlock
List<Project__c> ProjList = [SELECT Id From Project__c];
//Check locked records
List<Project__c> ProjLockList = new List<Project__c>();
for(Project__c p :ProjList){
    if(Approval.isLocked(p.id)){
        ProjLockList.add(p);
    }
}
//Unlock record
if(!ProjLockList.isEmpty()){
    //Unlock records
    List<Approval.UnlockResult> ulrList = Approval.unlock(ProjLockList, false);
      
    // Iterate through each returned result
    for(Approval.UnlockResult  ulr : ulrList) {
        if (ulr.isSuccess()) {
            //Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully unlocked project with ID: ' + ulr.getId());
        }
        else {
            //Operation failed, so get all errors                
            for(Database.Error err : ulr.getErrors()) {
                System.debug('The following error has occurred.');                    
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
            }
        }
    }
}