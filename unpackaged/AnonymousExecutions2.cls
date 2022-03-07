Contact c = [SELECT Name, Id, Phone, Member_Status__c, (SELECT Name, UserName, Id, AboutMe, isActive, Email FROM Users) FROM Contact WHERE Id = '0037j00000atmHQAAY'][0];

System.debug(loggingLevel.INFO, 'The Contact Record:' + c);
System.debug(loggingLevel.INFO, 'The Contact Name:' + c.Name);
System.debug(loggingLevel.INFO, 'The Contact Phone:' + c.Phone);
System.debug(loggingLevel.INFO, 'Users.size(): ' + c.Users.size());
System.debug(loggingLevel.INFO, 'The User Record: ' + c.Users[0]);
System.debug(loggingLevel.INFO, 'The UserName: ' + c.Users[0].UserName);
System.debug(loggingLevel.INFO, 'The isActive: ' + c.Users[0].isActive);
System.debug(loggingLevel.INFO, 'The Email: ' + c.Users[0].Email);
System.debug(loggingLevel.INFO, 'The AboutMe: ' + c.Users[0].AboutMe);

c.Phone = '6307888303';
c.Users[0].AboutMe = 'Wwwwww!';

update c;
//update c.Users[0];
System.debug(loggingLevel.INFO, 'The AboutMe: ' + c.Users[0].AboutMe);
