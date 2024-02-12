/**
 * @description       : LWC Component JS used for rendering a notification on any object
 * @author            : daniel@hyphen8.com
 * @last modified on  : 12-02-2024
 * @last modified by  : daniel@hyphen8.com
**/
import { LightningElement, api, wire } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getNotificationMessage from '@salesforce/apex/NotificationController.getMessage';
import { getRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/notificationUtils';
import labels from 'c/labels';

export default class Notification extends LightningElement {

    @api recordId;
    @api objectApiName;
    @api notificationTitle;
    @api fieldAPIName;
    @api componentStyling;
    @api notificationMessage;
    @api notificationCriteria;
    @api notificationIcon;
    message;
    hasMessages;
    label = labels;

    // getter to determine the SLDS style in on this renderinging
    get scopedVariant() {
        if(this.componentStyling == labels.notificationSLDSThemeSuccess){
            return labels.notificationSLDSThemeSuccessError;
        } else if(this.componentStyling == labels.notificationSLDSThemeWarning){
            return labels.notificationSLDSThemeWarningReturn;
        } else if(this.componentStyling == labels.notificationSLDSThemeError){
            return labels.notificationSLDSThemeErrorReturn;
        } else if(this.componentStyling == labels.notificationSLDSThemeInfo){
            return labels.notificationSLDSThemeInfoReturn;
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
            this.showToast(labels.notificationWireErrorToastTitle, 
                            reduceErrors(error).toString(), 
                            labels.notificationErrorToastType);
        }
    };

    // apex function to get our message to display
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
            this.showToast(labels.notificationApexErrorToastTitle, 
                            reduceErrors(error).toString(), 
                            labels.notificationErrorToastType);
            this.messages = undefined;
        });
    }

    // get the styling for the alert based on the property
    get alertStyling() {
        return labels.notificationAlertStylingCSS + ' ' + this.componentStyling;
    }

    // intial call back get out data
    connectedCallback() {
        this.handleGetMessages();        
    }

    // handle errors no output for it back handling anyway
    errorCallback(error) {
        this.errors = error;
    }

    // generic dispatch toast event
    showToast(toastTitle, toastMessage, toastVariant){
       this.dispatchEvent(new ShowToastEvent({title: toastTitle, message: toastMessage, variant: toastVariant}));
    }

}