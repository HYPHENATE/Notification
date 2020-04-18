/**
 * @description     help class for use with the notification controller
 * @author          daniel@hyphen8.com
 * @date            18/04/2020
 * @group           Helper
*/
public with sharing class NotificationHelper {   

    /**
    * @description  Will take in a field name which can be a referenced field e.g Object.RecordType.DeveloperName 
    *               and parse the object dynamically and return the value of that field from the record supplied
    * @param        Sobject record this is the record that we are reviewing
    * @param        string sOQLField this is the field on the record that we need to review
    * @return       Object this is the object with the value in it
    */
    public static Object getSObjectField(sObject record, string sOQLField) {
    
        // set an null object
        Object resultObj = null;
        // only process if the field is not null
        if (sOQLField != null) {
            // split the field down so we can have parent relationships
            List<String> sOQLFields = sOQLField.Split('\\.');
            system.debug('sOQLFields > ' + sOQLFields);
            
            // if only 1 entry in the list process if not split and repeat until we get the value
            if(sOQLFields.size() == 1) {
                resultObj = record.get(sOQLFields[0]);            
            } else {
                string sOQLRelationship = sOQLFields.remove(0);
                resultObj = getSObjectField(record.getSobject(sOQLRelationship), String.join(sOQLFields, '.'));         
            }
        }  
        // return our object
        return resultObj;     
    }
}