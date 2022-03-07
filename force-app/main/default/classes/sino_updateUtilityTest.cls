@IsTest
public with sharing class sino_updateUtilityTest {
    @IsTest
    static void testUpdateUtility() {
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

        sino_updateUtility.updateMemberToInactive(con.Id);
        List<Id> tester = new List<Id>();
        tester.add(con.Id);

        sino_updateUtility.updateListMemberStatusToInactive(tester);
    }
}