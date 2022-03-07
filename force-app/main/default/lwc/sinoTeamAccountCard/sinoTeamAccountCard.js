import { LightningElement, wire, track } from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
import TEAMID_FIELD from '@salesforce/schema/User.UserTeamId__c';

export default class WireGetRecordCurrentUser extends LightningElement {
    //@api recordId;
    userId = Id;

    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }

    @wire(getRecord, { recordId: '$userId', fields: [EMAIL_FIELD, TEAMID_FIELD] })
    //@wire(getRecord, { recordId: '$Id', fields: [EMAIL_FIELD, TEAMID_FIELD] })
    user;

    get email() {
        return getFieldValue(this.user.data, EMAIL_FIELD);
    }
    get userteamid() {
        return getFieldValue(this.user.data, TEAMID_FIELD);
    }
}