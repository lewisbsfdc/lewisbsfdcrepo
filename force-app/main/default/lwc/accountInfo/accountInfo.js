import { LightningElement, track, wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import {CurrentPageReference} from 'lightning/navigation';
import {registerListener, unregisterAllListeners} from 'c/pubsub';

const fields = [
    'Account.Name',
    'Account.AnnualRevenue',
    'Account.NumberOfEmployees'

];

export default class AccountInfo extends LightningElement {
    @track account;
    @track accountId;
    @wire (CurrentPageReference) pageref;

    connectedCallback() {
        registerListener('accountSelected', this.handleAccountSelected, this);
    }

    disconnectedCallback() {
        unRegisterAllListeners(this);
    }

    @wire(getRecord, {recordId: '$accountId', fields})
    account;

    handleAccountSelected(accId){
        this.accountId = accId;
    }
}