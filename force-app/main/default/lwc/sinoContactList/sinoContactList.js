import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getContactList from '@salesforce/apex/sino_listController.getContactList';
import Id from '@salesforce/user/Id'

export default class SinoContactList extends NavigationMixin(LightningElement) {
    data;

    @wire(getContactList, {userId: Id})
    contacts({error, data}) {
        if(data) {
            this.data = data.map((result) => {
                let row = JSON.parse(JSON.stringify(result));
                function getLink(objectId) {
                    return "/shinealight/s/detail/" + objectId;
                }
                row.EntryLink = getLink(row.Id);
                return row;
            });
        } else if(error) {
            data = null;
            console.log(error);
            console.log(Id);
        }
    };

    viewAll() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'list'
            },
            state: {
                filterName: '00B61000002GMEFEA4'
            }
        });
    }
}