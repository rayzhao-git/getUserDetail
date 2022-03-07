public without sharing class sinoDeactivateMemberController {


    public sinoDeactivateMemberController() {
    }

    @TestVisible
    @AuraEnabled
    public static Map<Integer, String> deactivateMember(Id conId) {

        Map<Integer, String> rMap = new Map<Integer, String>();
        try {
            
            System.debug(loggingLevel.INFO, 'Starting deactivateMember... conId: <' + conId + '>');

            Id uId = null;
            List<User> lstU = [SELECT Name, UserName, Id, isActive, Email 
                                FROM User 
                                WHERE ContactId = : conId AND isActive = true 
                                LIMIT 1];

            System.debug(loggingLevel.INFO, 'in deactivateMember... lstU.size(): <' + lstU.size() + '>');
            if (lstU.size() > 0){
                System.debug(loggingLevel.INFO, 'in deactivateMember... Found active user for the Contact: <' + lstU[0] + '>');
                Id currentUserId = UserInfo.getUserId();
                if (lstU[0].Id == currentUserId){
                    rMap.put(0,'Error-001: You cannot deactivate yourself!');
                }    
                else {
                    deactivateUser(lstU[0].Id);
                    rMap.put(1,'Success');
                }
            }
            else {
                rMap.put(0,'Error-002: Cannot deactivate, unable to find the active user for this team Member! Might have already been Inactive!');
            }     
            return rMap;
        }
        catch (Exception e){
            System.debug(loggingLevel.INFO, 'Exception: ' + e);
            rMap.put(0, 'Exception: ' + e);
            return rMap;
        }
    }

    @future 
    public static void deactivateUser(Id uId){
        try {
            System.debug(loggingLevel.INFO, 'uId: <' + uId + '>');
            User u = new User(Id = uId, isActive=false);
            Update u;
        }
        catch (Exception e){
            System.debug(loggingLevel.INFO, 'Exception: ' + e);
       }
    }
}
