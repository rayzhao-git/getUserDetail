import { LightningElement, api } from 'lwc';
import DEACTIVATION_HEADER from '@salesforce/label/c.Deactivate_Confirmation_Header';
import DEACTIVATION_MESSAGE from '@salesforce/label/c.Deactivate_Confirmation_Message';

export default class ConfirmationDialog extends LightningElement {
    @api recordId;
    @api name; //reference name of the component
    @api confirmLabel; //confirm button label
    @api cancelLabel; //cancel button label
    @api originalMessage; //any event/message/detail to be published back to the parent component
    visible = true;
    header = DEACTIVATION_HEADER;
    message = DEACTIVATION_MESSAGE;

    //handles button clicks
    handleClick(event){
        //creates object which will be published to the parent component
        let finalEvent = {
            originalMessage: this.originalMessage,
            status: event.target.name
        };

        //dispatch a 'click' event so the parent component can handle it
        this.dispatchEvent(new CustomEvent('click', {detail: finalEvent}));
    }
}