import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getProjectList from '@salesforce/apex/sino_listController.getProjectList';
import Id from '@salesforce/user/Id'

export default class ProjectListComponent extends NavigationMixin(LightningElement) {
    data;

    @wire(getProjectList, {userId: Id})
    projects({error, data}) {
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
                objectApiName: 'Project__c',
                actionName: 'list'
            },
            state: {
                filterName: '00B7j0000012j0iEAA'
            }
        });
    }
}