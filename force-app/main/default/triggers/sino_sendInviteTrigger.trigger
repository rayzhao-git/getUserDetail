trigger sino_sendInviteTrigger on Prospect__c (before insert, before update) {
	if(Trigger.isInsert) {
		for(Prospect__c a : Trigger.new) {
			Id jshu = [SELECT Id FROM User WHERE alias='jshu' LIMIT 1].Id;
			Contact con = sino_createUtility.createContactWithOwner(a.Account__c, a.First_Name__c, a.Last_Name__c, a.Email__c, jshu);
			a.Contact__c = con.Id;
		}
	}

	Messaging.SingleEmailMessage[] emails = new List<Messaging.SingleEmailMessage>();

	for(Prospect__c a : Trigger.new) {
		if (a.Send_Invitation__c) {
			System.debug('Sending invitation to prospect email: ' + a.Email__c);

			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			
			// FOR NOW, just uncheck the checkbox and update invitation link
	
			String token = '{"timestamp":' + DateTime.now().getTime() + ',"id":"' + a.Contact__c + '"}';
			token = EncodingUtil.urlEncode(sino_createUtility.encrypt(token), 'UTF-8');
			String link = 'https://sinodev-fornextgen.cs203.force.com/shinealight/s/confirm-registration?token=' + token;
	
			a.Send_Invitation__c = false;

			Id conId = a.Contact__c;
			Contact con = [ SELECT Invitation_Link__c, Member_Status__c FROM Contact WHERE Id=:conId LIMIT 1];

			con.Invitation_Link__c = link;
			con.Member_Status__c = 'Invited';
			update con;
					
			// Finish sending the email
				
			mail.setToAddresses(new String[]{ a.Email__c });
			mail.setTemplateId(Id.valueOf('00X7j000000EMkFEAW'));
			mail.setTargetObjectId(a.Contact__c);
			mail.setSenderDisplayName('Shine A Light');
	
			emails.add(mail);
				
			// Validation rules to prevent checking checkboxes for already-accepted people
		}
	}
	if(emails.size() > 0) {
		System.debug('Sending all emails.');
		Messaging.sendEmail(emails);
	}
}