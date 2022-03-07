import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getTimeEntryList from '@salesforce/apex/sino_listController.getTimeEntryList';
import Id from '@salesforce/user/Id'

export default class SinoTimeEntryList extends NavigationMixin(LightningElement) {
    data;

    @wire(getTimeEntryList, {userId: Id})
    timeEntries({error, data}) {
        if(data) {
            this.data = data.map((result) => {
                let row = JSON.parse(JSON.stringify(result));
                function getLink(objectId) {
                    return "/shinealight/s/detail/" + objectId;
                }
                row.EntryLink = getLink(row.Id);
                row.ProjectLink = getLink(row.Project__r.Id);
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
                objectApiName: 'Time_Entry__c',
                actionName: 'list'
            },
            state: {
                filterName: '00B7j0000013otaEAA'
            }
        });
    }
}