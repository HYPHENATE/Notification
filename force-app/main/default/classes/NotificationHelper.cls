/**
 * @description     help class for use with the notification controller
 * @author          daniel@hyphen8.com
 * @date            18/04/2020
 * @group           Helper
*/
/**
 * @description       : Helper class for the notification component
 * @author            : daniel@hyphen8.com
 * @last modified on  : 12-02-2024
 * @last modified by  : daniel@hyphen8.com
**/
public with sharing class NotificationHelper {   

    /**
    * @description  Will take in a field name which can be a referenced field e.g Object.RecordType.DeveloperName 
    *               and parse the object dynamically and return the value of that field from the record supplied
    * @param        sObject 
    * @param        String 
    * @return       Object
    */
    public static Object getSObjectField(sObject record, String sOQLField) {
        Object resultObj = null;
        if (sOQLField != null) {
            List<String> sOQLFields = sOQLField.Split('\\.');
            if(sOQLFields.size() == 1) {
                resultObj = record.get(sOQLFields[0]);            
            } else {
                string sOQLRelationship = sOQLFields.remove(0);
                resultObj = getSObjectField(record.getSobject(sOQLRelationship), String.join(sOQLFields, '.'));         
            }
        }  
        return resultObj;     
    }
}