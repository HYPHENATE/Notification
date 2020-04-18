import { LightningElement, track, api } from 'lwc';

import getNotificationMessage from '@salesforce/apex/NotificationController.getMessage';

export default class Notification extends LightningElement {

    // setup api elements
    @api recordId;
    @api objectApiName;
    @api notificationtitle;
    @api fieldAPIName;
    @api componentstyling;

    // setup track elements
    @track message;
    @track errors;
    @track hasMessages;

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
    get alertstyling() {
        return 'slds-notify slds-p-around_medium ' + this.componentstyling;
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