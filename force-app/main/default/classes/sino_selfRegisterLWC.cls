/****************************************************************************
Name: sino_selfRegisterLWC
===============================================================================
Purpose:                                                            
Used as a Register screen in community
===============================================================================
History                                                                                                                       
VERSION     AUTHOR                               DATE             DETAIL
1.0         Ray Zhao                             12/26/2018       Initial Development 
******************************************************************************/
public without sharing class sino_selfRegisterLWC {
    /**************************************************************************
    Purpose    : method called upon submit of sign up button
    Parameters : String TeamName, FirstName, LastName, EmailAddr
    Returns    : String
    Exceptions : DMLException
    **************************************************************************/
    @AuraEnabled
    public static string selfRegister(String TeamName, String FirstName, String LastName, String EmailAddr, String TeamDesc, String Phone){

        // create a fake userId for test.
        //if(Test.isRunningTest()) {
        //    return  'fake user';  // modify 
        //}
        String userId ;
        list<Contact> conList = [SELECT Id, AccountId, Email, FirstName, LastName FROM Contact WHERE Email = : EmailAddr LIMIT 1];
        // Debug log if the email belongs to a Contact
        System.Debug(LoggingLevel.INFO, '### Found ' + conList.size() + ' contact(s).');
        if(!conList.isEmpty()){
            //perform some steps
            //to be defined later
            return 'This email address is already a contact.';
        }
        else
        {
            Savepoint sp = Database.setSavepoint();
            try {
                Account acc = sino_createUtility.createTeamWithDesc(TeamName, TeamDesc);
                Contact con = sino_createUtility.createMemberContactWithPhone(acc.Id, FirstName, LastName, EmailAddr, Phone);

                //generate community nickname

                String nameString = FirstName + LastName;
                if (nameString.length() > 20) {
                    nameString = nameString.substring(0, 20);
                }
                String communityNick = nameString + DateTime.now().getTime();
                return sino_createUtility.createLeadUser(acc.Id, Firstname, LastName, EmailAddr, communityNick);
            }
            catch (Exception ex) {
                Database.rollback(sp);
                System.debug(ex.getMessage());
                return ex.getMessage();            
            }
        }
    }
}