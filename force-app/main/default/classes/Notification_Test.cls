/**
 * @description     test class for Notification app
 * @author          daniel@hyphen8.com
 * @date            18/04/2020
 * @group           Tests
*/
@isTest
public with sharing class Notification_Test {
    

    /**
     * @description basic simple test
    */
    static testMethod void testcurrentrecordfield(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;

        string notificationmessage = NotificationController.getMessage(acc.Id, 'Account', 'Name');
        system.assertEquals('TestAccount1', notificationmessage, 'Correct Message Returned');

    }

    /**
     * @description basic parent test
    */
    static testMethod void testparentrecordfield(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(con.Id, 'Contact', 'Account.Name');
        system.assertEquals('TestAccount1', notificationmessage, 'Correct Message Returned');

    }

    /**
     * @description error test
    */
    static testMethod void testerror(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(con.Id, 'Contact', 'LastNameINGFIELD');
        system.assertEquals(Label.NotificationErrorProcessing, notificationmessage, 'Correct Message Returned');

    }

}