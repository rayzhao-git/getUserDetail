import { LightningElement, wire, track } from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
import TEAMID_FIELD from '@salesforce/schema/User.UserTeamId__c';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {CloseActionScreenEvent} from 'lightning/actions';

export default class ModalPopupLWC extends LightningElement {
    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    handleSuccess() {
        const toast = new ShowToastEvent({
            title: 'Success',
            variant: 'Success',
            message: 'Project created successfully'
        });
        this.dispatchEvent(toast);
        this.isModalOpen = false;
    }

    userId = Id;

    @wire(getRecord, { recordId: '$userId', fields: [EMAIL_FIELD, TEAMID_FIELD] })
    user;

    get email() {
        return getFieldValue(this.user.data, EMAIL_FIELD);
    }
    get userteamid() {
        return getFieldValue(this.user.data, TEAMID_FIELD);
    }

}