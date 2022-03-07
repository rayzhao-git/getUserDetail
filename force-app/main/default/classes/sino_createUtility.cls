public without sharing class sino_createUtility {
    @AuraEnabled
    public static Account createTeam(String TeamName) {
        // Create Account by using TeamName
        Account accountRecord = new Account(
                                    Name = TeamName,
                                    recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Volunteer_Team').getRecordTypeId(),
                                    Team_Status__c = 'New'
                                );
        Insert accountRecord;
        System.Debug(LoggingLevel.INFO, '### Account Created, Id = ' + accountRecord.Id);

        return accountRecord;
    }

    @AuraEnabled
    public static Account createTeamWithDesc(String TeamName, String TeamDesc) {
        // Create Account by using TeamName
        Account accountRecord = new Account(
                                    Name = TeamName,
                                    Description = TeamDesc,
                                    recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Volunteer_Team').getRecordTypeId(),
                                    Team_Status__c = 'New'
                                );
        Insert accountRecord;
        System.Debug(LoggingLevel.INFO, '### Account Created, Id = ' + accountRecord.Id);

        return accountRecord;
    }

    @AuraEnabled
    public static Contact createContact(Id accountId, String FirstName, String LastName, String EmailAddr) {
        // Create Contact by using FN, LN, Email
        Contact contactRecord = new Contact(
                                    AccountId = accountId,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    Email = EmailAddr
                                    );
        Insert contactRecord;
        System.Debug(LoggingLevel.INFO, '### Contact Created, Id = ' + contactRecord.Id);

        return contactRecord;
    }

    @AuraEnabled
    public static Contact createMemberContact(Id accountId, String FirstName, String LastName, String EmailAddr) {
        // Create Contact by using FN, LN, Email
        Contact contactRecord = new Contact(
                                    AccountId = accountId,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    Email = EmailAddr,
                                    RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('sino_Member').getRecordTypeId()
                                    );
        Insert contactRecord;
        System.Debug(LoggingLevel.INFO, '### Contact Created, Id = ' + contactRecord.Id);

        return contactRecord;
    }

    @AuraEnabled
    public static Contact createMemberContactWithPhone(Id accountId, String FirstName, String LastName, String EmailAddr, String Phone) {
        // Create Contact by using FN, LN, Email, Phone
        Contact contactRecord = new Contact(
                                    AccountId = accountId,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    Email = EmailAddr,
                                    Phone = Phone,
                                    RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('sino_Member').getRecordTypeId()
                                    );
        Insert contactRecord;
        System.Debug(LoggingLevel.INFO, '### Contact Created, Id = ' + contactRecord.Id);

        return contactRecord;
    }

    @AuraEnabled
    public static Contact createContactWithOwner(Id accountId, String FirstName, String LastName, String EmailAddr, Id ownerId) {
        // Create Contact by using FN, LN, Email
        Contact contactRecord = new Contact(
                                    AccountId = accountId,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    Email = EmailAddr,
                                    OwnerId = ownerId
                                    );
        Insert contactRecord;
        System.Debug(LoggingLevel.INFO, '### Contact Created, Id = ' + contactRecord.Id);

        return contactRecord;
    }

    @AuraEnabled
    public static string createUser(Id accountId, String FirstName, String LastName, String EmailAddr, String CommunityNickname) {
        // Create a user record
        User userRecord = new User(
                                    Username = EmailAddr,
                                    Email = EmailAddr,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    CommunityNickname = CommunityNickname,
                                    ProfileId = getProfileIdByName('ForNextGen Customer Community Login User')
                                );
        // Link the user to the contact record to make it an External User, by calling the createExternalUser() method
        return (site.createExternalUser(userRecord, accountId, null, true));
    }

    @AuraEnabled
    public static string createInvitedUser(Id accountId, String FirstName, String LastName, String EmailAddr, String CommunityNickname, String Password, String Confirm) {
        // Create a user record
        User userRecord = new User(
                                    Username = EmailAddr,
                                    Email = EmailAddr,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    CommunityNickname = CommunityNickname,
                                    ProfileId = getProfileIdByName('ForNextGen Customer Community Login User')
                                );
        // Link the user to the contact record to make it an External User, by calling the createExternalUser() method (check the password)
        site.validatePassword(userRecord, Password, Confirm);
        return (site.createExternalUser(userRecord, accountId, Password, false));
    }

    @AuraEnabled
    public static string createLeadUser(Id accountId, String FirstName, String LastName, String EmailAddr, String CommunityNickname) {
        // Create a user record
        User userRecord = new User(
                                    Username = EmailAddr,
                                    Email = EmailAddr,
                                    FirstName = FirstName,
                                    LastName = LastName,
                                    CommunityNickname = CommunityNickname,
                                    ProfileId = getProfileIdByName('ForNextGen Customer Community Lead User')
                                );
        // Link the user to the contact record to make it an External User, by calling the createExternalUser() method
        return (site.createExternalUser(userRecord, accountId, null, true));
    }

    public static Id getProfileIdByName(String Name) {
        return [SELECT Id FROM Profile WHERE name=:Name LIMIT 1].Id;
    }

    public static string encrypt(String str) {
        Blob key = EncodingUtil.base64Decode(label.Invitation_Link_Key);
        System.debug(loggingLevel.INFO, 'Key is: ' + EncodingUtil.base64Encode(key));

        Blob data = Blob.valueOf(str);
        Blob encrypted = Crypto.encryptWithManagedIV('AES128', key, data);
        System.debug(loggingLevel.INFO, 'Encrypted String is: ' + EncodingUtil.base64Encode(encrypted));

        return EncodingUtil.base64Encode(encrypted);
    }

    public static string decrypt(String str) {
        Blob key = EncodingUtil.base64Decode(label.Invitation_Link_Key);
        System.debug(loggingLevel.INFO, 'Key is: ' + EncodingUtil.base64Encode(key));

        Blob data = EncodingUtil.base64Decode(str);
        Blob decrypted = Crypto.decryptWithManagedIV('AES128', key, data);
        System.debug(loggingLevel.INFO, 'Decrypted String is: ' + decrypted.toString());

        return decrypted.toString();
    }
}