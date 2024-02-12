/**
 * @description       : Enhanced notification component for display either a specific field value or a validation based on a query
 * @author            : daniel@hyphen8.com
 * @last modified on  : 12-02-2024
 * @last modified by  : daniel@hyphen8.com
**/
public with sharing class NotificationController {

    /**
     * @description         aura method that takes a recordid / objectname and fieldapi name 
     *                      and then returns the contents of the field to the lightning component
     * @param               recordId 
     * @param               objectName 
     * @param               fieldAPIName 
     * @param               whereClause
     * @return              string
    */
    @SuppressWarnings('PMD.ExcessiveParameterList, PMD.ApexSOQLInjection')
    @AuraEnabled
    public static String getMessage(String recordId, String objectName, String fieldAPIName, String whereClause){
        string message;
        string query = '';
        List<sObject> whereResults = new List<sObject>();

        try {
            if(null != whereClause){
                query += 'SELECT Id FROM ' + objectName + ' WHERE ' + whereClause + ' AND ID=:recordId';
                whereResults = Database.query(query);
                message = (whereResults.size() == 0) ? '' : System.Label.NotificationValidationMatch;
            } else {
                query += 'SELECT ' + fieldAPIName + ' FROM ' + objectName + ' WHERE ID=:recordId';
                sObject sobj = Database.query(string.escapeSingleQuotes(query));
                object returnmessage = NotificationHelper.getSObjectField(sobj, fieldAPIName);
                message = String.escapeSingleQuotes(String.valueof(returnmessage));
            }
        } catch (Exception e){
            message = Label.NotificationErrorProcessing;
        }
        return message;
    }
}