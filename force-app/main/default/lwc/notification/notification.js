/**
 * @description       : 
 * @author            : daniel@hyphen8.com
 * @group             : 
 * @last modified on  : 16/06/2022
 * @last modified by  : daniel@hyphen8.com
 * Modifications Log 
 * Ver   Date         Author               Modification
 * 1.0   01-08-2021   daniel@hyphen8.com   Initial Version
**/
import { LightningElement, api, wire } from 'lwc';

import getNotificationMessage from '@salesforce/apex/NotificationController.getMessage';
import { getRecord } from 'lightning/uiRecordApi';


export default class Notification extends LightningElement {

    @api recordId;
    @api objectApiName;
    @api notificationTitle;
    @api fieldAPIName;
    @api notificationStyling;
    @api notificationMessage;
    @api notificationCriteria;
    @api notificationIcon;


    message;
    hasMessages;

    get scopedVariant() {
        if(this.notificationStyling == 'slds-theme_success'){
            return 'inverse';
        } else if(this.notificationStyling == 'slds-theme_warning'){
            return 'warning';
        } else if(this.notificationStyling == 'slds-theme_error'){
            return 'inverse';
        } else if(this.notificationStyling == 'slds-theme_info'){
            return 'inverse';
        } else {
            return '';
        }
    }

    // Wire function that is used to detect changes on the record and rerun the get messages method
    @wire(getRecord, { recordId: '$recordId', layoutTypes: ['Full']})
    getCurrentRecord({ data, error }) {
        if (data) {
            this.handleGetMessages();
        } else if (error) {
            console.error('Wire Error Encountered => ', JSON.stringify(error));
        }
    };

    // function to get our message to display
    handleGetMessages() {
        getNotificationMessage({
            recordId: this.recordId,
            objectName: this.objectApiName,
            fieldAPIName: this.fieldAPIName,
            whereClause: this.notificationCriteria
        })
        .then((results) => {
            if(this.notificationCriteria != null){
                this.message = this.notificationMessage;
            } else {
                this.message = results;
            }
            if(results.length > 0){
                this.hasMessages = true;
            } else {
                this.hasMessages = false;
            }
        })
        .catch((error) => {
            console.error('handleGetMessages error > ' + JSON.stringify(error));
            this.messages = undefined;
        });
    }

    // get the styling for the alert based on the property
    get alertStyling() {
        return 'slds-scoped-notification slds-media slds-media_center slds-is-relative slds-var-p-around_medium ' + this.notificationStyling;
    }

    // intial call back get out data
    connectedCallback() {
        this.handleGetMessages();        
    }

    // handle errors no output for it back handling anyway
    errorCallback(error) {
        this.errors = error;
    }

}