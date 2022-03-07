import { LightningElement, api } from 'lwc';
import NAME_FIELD1 from '@salesforce/schema/Account.Team_Status__c';
import NAME_FIELD2 from '@salesforce/schema/Account.Team_Approved_Date__c';

export default class TestTeamAccountCard extends LightningElement {
    nameField1 = NAME_FIELD1;
    nameField2 = NAME_FIELD2;
    recordId = '0017j00000cp7FQAAY';
    objectApiName = 'Account';
}