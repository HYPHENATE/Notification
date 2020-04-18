/**
* @description      Simple notification component for outputting values from a record
* @author           daniel@hyphen8.com
* @date             18/04/2020
* @group            Controller
*/
public with sharing class NotificationController {

    /**
     * @description         aura method that takes a recordid / objectname and fieldapi name and then returns the contents of the field to the lightning component
     * @param               recordId - this is the recordid you want to use to find data on the record
     * @param               objectName - this is the objectname that the method has been opened on
     * @param               fieldAPIName - this is the API name for the field you want to query
     * @return              string - either the actual field data for a message based on what happened
    */
    @AuraEnabled
    public static String getMessage(string recordId, string objectName, string fieldAPIName)
    {
        // setup a string for the message we will return
        string message;

        // try and get the message
        try {
            // setup our query
            string query = 'SELECT ' + fieldAPIName + ' FROM ' + objectName + ' WHERE ID=:recordId';
            // pull in the object we are on
            sObject sobj = Database.query(query);
            // get the return message
            object returnmessage = HelpMessageHelper.getSObjectField(sobj, fieldAPIName);
            // convert object to string
            message = string.valueof(returnmessage);
        } catch (Exception e){
            system.debug(e.getMessage());
            message = Label.NotificationErrorProcessing;
        }
        
        // return our message
        return message;
    }
}