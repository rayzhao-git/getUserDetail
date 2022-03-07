trigger sinoUpdateMemberStatusToInactive on User (after update) {

    List<Id> lstConId = new List<Id>();
    for (User u : Trigger.New){
        
        System.Debug(LoggingLevel.INFO, '### for u = <' + u + '> Id: <'+ u.Id + '>');
        //find the External(Contact Id not empty) Users that changed from Active to Inactive(isActive from true to false) 
        if (u.isActive == false && u.isActive != Trigger.oldMap.get(u.Id).isActive && u.ContactId != null){
            lstConId.Add(u.ContactId);
        }
    }

    System.Debug(LoggingLevel.INFO, '### list of contact ids = <' + lstConId + '>');
    if (lstConId.size()>0){
        sino_updateUtility.updateListMemberStatusToInactive(lstConId);
    }

}