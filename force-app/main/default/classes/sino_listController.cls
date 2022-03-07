public with sharing class sino_listController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> getTimeEntryList(Id userId) {
        return [SELECT Name, Hours_Worked__c,
        Project__r.Name, Start_Date__c, End_Date__c, CreatedById
        FROM Time_Entry__c
        WHERE CreatedById = :userId
        ORDER BY LastModifiedDate DESC
        LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getProjectList(Id userId) {
        return [SELECT Name, Status__c, Start_Date__c, Project_Approved_Date__c 
        FROM Project__c
        ORDER BY LastModifiedDate DESC
        LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> getContactList(Id userId) {
        return [SELECT Name, Phone, Email, WeChat_ID__c, Description, Member_Status__c 
        FROM Contact
        ORDER BY LastModifiedDate DESC
        LIMIT 5];
    }
}