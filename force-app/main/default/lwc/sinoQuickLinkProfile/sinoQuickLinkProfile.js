import { LightningElement, track } from 'lwc';
import Id from '@salesforce/user/Id';
export default class ModalPopupLWC extends LightningElement {
    userId = Id;
    @track isModalOpen = false;
    goToProfile() {
        //alert('clicked');
        window.location.href="/s/profile/home";
    }
}