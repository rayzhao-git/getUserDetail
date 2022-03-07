import { LightningElement, wire, track } from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import EMAIL_FIELD from '@salesforce/schema/User.Email';
import TEAMID_FIELD from '@salesforce/schema/User.UserTeamId__c';
import CONTACTID_FIELD from '@salesforce/schema/User.ContactId';
import HERO_PROFILE_BANNER from '@salesforce/contentAssetUrl/hero_profile_banner_nobar';

export default class WireGetRecordCurrentUser extends LightningElement {
    //@api recordId;
    userId = Id;
    hero_profile_banner = HERO_PROFILE_BANNER;
    //userid = '0057j000002jVvMAAU';
    //console.log("cObj===>"+ userid );

    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }

    @wire(getRecord, { recordId: '$userId', fields: [EMAIL_FIELD, TEAMID_FIELD, CONTACTID_FIELD] })
    //@wire(getRecord, { recordId: '$Id', fields: [EMAIL_FIELD, TEAMID_FIELD] })
    user;

    get email() {
        return getFieldValue(this.user.data, EMAIL_FIELD);
    }
    get userteamid() {
        return getFieldValue(this.user.data, TEAMID_FIELD);
    }
    get contactid(){
        //return "0037j00000dHYsoAAG";
        return getFieldValue(this.user.data, CONTACTID_FIELD);
    }
}