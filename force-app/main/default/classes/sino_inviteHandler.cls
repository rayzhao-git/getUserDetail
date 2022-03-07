public without sharing class sino_inviteHandler {
    @AuraEnabled
    public static String[] handleInvite(String InviteToken, String Password, String Confirm) {
        System.debug('Current invite token: ' + InviteToken);

        InviteToken = sino_createUtility.decrypt(InviteToken);
        System.debug('Decrypted invite token: ' + InviteToken);

        // Read JSON
        Id contactId;
        Long timestamp;
        JSONParser parser = JSON.createParser(InviteToken);
        while(parser.nextToken() != null) {
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText() == 'timestamp') {
                parser.nextToken();
                timestamp = parser.getLongValue();
            }
            else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && parser.getText() == 'id') {
                parser.nextToken();
                contactId = parser.getIdValue();
            }
        }

        Long currentTime = DateTime.now().getTime();
        if(currentTime - timestamp > (3 * 86400 * 1000)) { //3 day time limit
            String[] strs = new List<String>();
            strs.add('Timestamp is expired.');
            strs.add(null);
            return strs;
        }

        Savepoint sp = Database.setSavepoint();
        try {
            Contact con = [SELECT Id, AccountId, FirstName, LastName, Email, RecordTypeId, Member_Status__c FROM Contact WHERE Id = :contactId LIMIT 1];

            //generate community nickname
            String firstName = con.FirstName;
            String lastName = con.LastName;
            String nameString = firstName + lastName;
            if (nameString.length() > 20) {
                nameString = nameString.substring(0, 20);
            }
            String communityNick = nameString + DateTime.now().getTime();
            
            String userCreation = sino_createUtility.createInvitedUser(con.AccountId, firstname, lastName, con.Email, communityNick, Password, Confirm);
            con.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('sino_Member').getRecordTypeId();
            con.Member_Status__c = 'Joined';
            Update con;
            System.PageReference reference = Site.login(con.Email, Password, '/shinealight/s');
            String[] strs = new List<String>();
            strs.add(userCreation);
            strs.add(reference.getUrl());
            return strs;
        }
        catch (Exception ex) {
            Database.rollback(sp);
            System.debug(ex.getMessage());
            String[] strs = new List<String>();
            strs.add(ex.getMessage());
            strs.add(null);
            return strs;
        }
    }
}