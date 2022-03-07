import { LightningElement, track } from 'lwc';
export default class ModalPopupLWC extends LightningElement {
    @track isModalOpen = false;
    goToSettings() {
        //alert('clicked');
        window.location.href="/s/settings/home";
    }
}