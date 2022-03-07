import { LightningElement } from 'lwc';
import selfRegister from '@salesforce/apex/sino_selfRegisterLWC.selfRegister'
import { NavigationMixin } from 'lightning/navigation';

export default class SelfRegistrationComponent extends NavigationMixin(LightningElement) {
	teamName;
	firstName;
	lastName;
	emailAddress;
	teamDesc;
	phone;
	show = true;
	showSuccess = false;
	showFailure = false;

	updateTeamName(event) {
		this.teamName = event.target.value;
	}

	updateFirstName(event) {
		this.firstName = event.target.value;
	}

	updateLastName(event) {
		this.lastName = event.target.value;
	}

	updateEmail(event) {
		this.emailAddress = event.target.value;
	}

	updatePhone(event) {
		this.phone = event.target.value;
	}

	updateTeamDesc(event) {
		this.teamDesc = event.target.value;
	}

	register() {
		// Do not attempt to register in the frontend; pass it all to an Apex class instead
		selfRegister({
			TeamName: this.teamName,
			FirstName: this.firstName,
			LastName: this.lastName,
			EmailAddr: this.emailAddress,
			TeamDesc: this.teamDesc,
			Phone: this.phone
		}).then((result) => {
			console.log("Success!");
			console.log(result);
			console.log('Substring(0,3): <' +result.substr(0,3) + '>');
			this.show = false;
			if (result.substr(0,3) === '005')
				this.showSuccess = true;
			else
				this.showFailure = true;
		});
	}

	backToLogin(){
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            },
        });
    }
	backToRegister(){
		this[NavigationMixin.Navigate]({
			type: 'standard__webPage',
			attributes: {
				url: '/SelfRegister'
			},
		});
	}
}