import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountListAuraController.getAccounts';
import {CurrentPageReference} from 'lightning/navigation';
import {fireEvent} from 'c/pubsub';

const actions = [
    {label: 'Show Details', name: 'show_details'}
];

const table_columns = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Website', fieldName: 'Website', type: 'url'},
    {label: 'Description', fieldName: 'Description', type: 'text'},
    {
        type: 'action',
        typeAttributes: {rowActions: actions},
    }
];

export default class AccountList extends LightningElement {
    columns = table_columns;
    @wire(getAccounts) accounts;
    @wire(CurrentPageReference) pageref;

    handleRowAction(event){
        const row = event.detail.row;
        this.showRowDetails(row);

    }

    showRowDetails(row){
        fireEvent(this.pageref, 'accountSelected', row.Id);
    }
}