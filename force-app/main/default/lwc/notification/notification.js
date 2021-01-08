/**
 * @description       : 
 * @author            : daniel@hyphen8.com
 * @group             : 
 * @last modified on  : 01-08-2021
 * @last modified by  : daniel@hyphen8.com
 * Modifications Log 
 * Ver   Date         Author               Modification
 * 1.0   01-08-2021   daniel@hyphen8.com   Initial Version
**/
import { LightningElement, track, api } from 'lwc';

import getNotificationMessage from '@salesforce/apex/NotificationController.getMessage';

export default class Notification extends LightningElement {

    // setup api elements
    @api recordId;
    @api objectApiName;
    @api notificationTitle;
    @api fieldAPIName;
    @api componentStyling;

    // setup track elements
    message;
    errors;
    hasMessages;

    // get our message to display
    handleGetMessages() {
        getNotificationMessage({
            recordId: this.recordId,
            objectName: this.objectApiName,
            fieldAPIName: this.fieldAPIName
        })
        .then((results) => {
            this.message = results;
            if(results.length > 0){
                this.hasMessages = true;
            } else {
                this.hasMessages = false;
            }
            this.errors = undefined;  
        })
        .catch((error) => {
            this.errors = JSON.stringify(error);
            this.messages = undefined;
        });
    }

    // get the styling for the alert based on the property
    get alertStyling() {
        return 'slds-notify slds-p-around_medium ' + this.componentStyling;
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