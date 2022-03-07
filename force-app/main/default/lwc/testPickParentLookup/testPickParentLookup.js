import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class Summer21 extends LightningElement {
    @api recordId;

    handleSuccess(){
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Record saved successfully'
        });
        this.dispatchEvent(event);
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}