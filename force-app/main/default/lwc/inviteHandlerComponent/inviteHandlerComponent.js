import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

import handleInvite from '@salesforce/apex/sino_inviteHandler.handleInvite'

export default class InviteHandlerComponent extends LightningElement {
    urlToken = null;
	currentPageReference = null;
	message = "";
	password = null;
	confirm = null;

	@wire(CurrentPageReference)
	getStateParameters(currentPageReference) {
		if (currentPageReference) {
			this.urlToken = currentPageReference.state.token || null;
		}
	}

	updatePassword (event) {
		this.password = event.target.value;
	}
	updateConfirm (event) {
		this.confirm = event.target.value;
	}

	run() {
		handleInvite({
			InviteToken: this.urlToken,
			Password: this.password,
			Confirm: this.confirm
		}).then((result) => {
			console.log("Success!");
			console.log(result);
			this.message = result[0];
			if(result[1]) {
				window.open(result[1], '_self')
			}
		});
	}
	
}