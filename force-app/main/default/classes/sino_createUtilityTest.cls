@IsTest
public with sharing class sino_createUtilityTest {
    @IsTest
    static void testCreateUtility() {
        // test team creation
        Account acc = sino_createUtility.createTeam('asdfgh');
        System.assertEquals(acc.Name, 'asdfgh', 'Team Creation');

        Account acc2 = sino_createUtility.createTeamWithDesc('asdfgh', 'Bottom Text');

        // test contact creation
        Contact con = sino_createUtility.createContact(acc.ID, 'Zany', 'Fail', 'test@gmail.com');
        Contact con2 = sino_createUtility.createMemberContact(acc.ID, 'Zany', 'Fail', 'test@gmail.com');
        Contact con3 = sino_createUtility.createMemberContactWithPhone(acc.ID, 'Zany', 'Fail', 'test@gmail.com', '123-123-1233');
        try {
            Contact con4 = sino_createUtility.createContactWithOwner(acc.ID, 'Zany', 'Fail', 'test@gmail.com', null);
        } catch (DmlException ex) {
            // expected
        }
        System.assertEquals(con.FirstName, 'Zany', 'Contact creation');

        String test = sino_createUtility.createUser(acc.ID, 'epic', 'grail', 'epicgrail@gmail.com', 'epick_grayl');
        String test2 = sino_createUtility.createLeadUser(acc.ID, 'epic', 'grail', 'epicgrail@gmail.com', 'epick_grayl');
        String test3 = sino_createUtility.createInvitedUser(acc.ID, 'epic', 'grail', 'epicgrail@gmail.com', 'epick_grayl', 'AmazingPassword12!', 'AmazingPassword12!');
    }
}