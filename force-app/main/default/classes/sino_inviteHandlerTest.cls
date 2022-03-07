@IsTest
public with sharing class sino_inviteHandlerTest {
    @IsTest(SeeAllData=true)
    static void testCreates() {
        // Create with expired timestamp
        System.assertEquals(sino_inviteHandler.handleInvite(
            '7cmuQIrSL07Dd9Hu8XiZIsUYXsr42JLbrHCDzF7QXV1WP23DRYfeHESqoSe+Ai61B1ZkytX+6u6griDm0QaLkiMkMYwo8Li+ajkExEwPTdM=',
            'Test123234234@',
            'Test123234234@'
        )[0], 'Timestamp is expired.', 'Create with expired timestamp');

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

        // Create with good timestamp
        String token = '{"timestamp":' + DateTime.now().getTime() + ',"id":"' + con.ID + '"}';
        token = sino_createUtility.encrypt(token);

        System.assertEquals(sino_inviteHandler.handleInvite(
            token,
            'Test123234234@',
            'Test123234234@'
        )[0], 'Attempt to de-reference a null object', 'Create valid invite');
    }
}