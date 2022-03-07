public without sharing class sino_updateUtility {

    @future
    public static void updateMemberToInactive(Id contactId) {
        // Create Contact by using FN, LN, Email
        Contact con = new Contact(Id = contactId,
                                    Member_Status__c = 'Inactive'
                                    );
        Update con;
        System.Debug(LoggingLevel.INFO, '### Contact Updated, Id = ' + con.Id + '> Status: <'+ con.Member_Status__c + '>');
    }

    @future
    public static void updateListMemberStatusToInactive(List<Id> lstConId) {
        // Calling party responsible for setting the correct Ids of the Contacts
        try{
            List<Contact> lstCon = new List<Contact>();
            for (Id cid : lstConId) {
                lstCon.Add(new Contact(Id=cid, Member_Status__c='Inactive'));
            }
            System.Debug(LoggingLevel.INFO, '### Contact list count, # of Contact = ' + lstCon.size() + '>');
            if (lstCon.size() > 0)
                update lstCon;
        }
        catch (Exception e){
            System.Debug(LoggingLevel.INFO, '### ' + e);
        }
    }
}
