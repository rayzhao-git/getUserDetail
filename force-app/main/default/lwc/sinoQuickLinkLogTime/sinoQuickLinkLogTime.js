import { LightningElement, track } from 'lwc';
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
            message: 'Time Entry created successfully'
        });
        this.dispatchEvent(toast);
        this.isModalOpen = false;
    }
}