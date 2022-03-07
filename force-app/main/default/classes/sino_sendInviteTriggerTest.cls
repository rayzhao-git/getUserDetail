@IsTest
public with sharing class sino_sendInviteTriggerTest {
    @IsTest
    static void sendInviteTriggers() {
        // Create dummy account and contact
        Account acc = new Account(Name='Test Account');
        insert acc;

        ID accId = acc.ID;

        Contact con = new Contact(
            FirstName='Yeetus',
            LastName='Deletus',
            AccountId=accId
        );
        insert con;

        Prospect__c pros = new Prospect__c();
        pros.Account__c = acc.Id;
        pros.Send_Invitation__c = true;
        pros.Email__c = 'stinggyray@gmail.com';
        pros.First_Name__c = 'Sting';
        pros.Last_Name__c = 'Gyray';

        insert pros;
        // should trigger email
    }
}