/**
 * @description       : Test class for Notification component
 * @author            : daniel@hyphen8.com
 * @last modified on  : 12-02-2024
 * @last modified by  : daniel@hyphen8.com
**/
@isTest
public class Notification_Test {
    

    /**
     * @description basic simple test
    */
    @isTest
    static void testcurrentrecordfield(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;

        string notificationmessage = NotificationController.getMessage(acc.Id, 'Account', 'Name', null);
        system.assertEquals('TestAccount1', notificationmessage, 'Different message returned');

    }

    /**
     * @description basic parent test
    */
    @isTest
    static void testparentrecordfield(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(con.Id, 'Contact', 'Account.Name', null);
        system.assertEquals('TestAccount1', notificationmessage, 'Different message returned');

    }

    /**
     * @description error test
    */
    @isTest
    static void testerror(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(con.Id, 'Contact', 'Email', null);
        system.assertEquals(null, notificationmessage, 'Different message returned');

    }

    /**
     * @description error test parent field
    */
    @isTest
    static void testerrorparent(){
        Account acc = new Account(Name='TestAccount1');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(con.Id, 'Contact', 'Account.NameINGERROR', null);
        system.assertEquals(System.Label.NotificationErrorProcessing, notificationmessage, 'Different message returned');

    }

    /**
     * @description query with where clause get a response
    */
    @isTest
    static void testSuccessWhereClause(){
        Account acc = new Account(Name='TestAccount1', Rating='Hot');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(acc.Id, 'Account', null, 'Rating = \'Hot\'');
        system.assertEquals(System.Label.NotificationValidationMatch, notificationmessage, 'Different message returned');

    }

    /**
     * @description query with where clause get no response
    */
    @isTest
    static void testSuccessWhereClauseFail(){
        Account acc = new Account(Name='TestAccount1', Rating='Hot');
        insert acc;
        Contact con = new Contact(LastName='TEST USER', AccountID=acc.Id);
        insert con;

        string notificationmessage = NotificationController.getMessage(acc.Id, 'Account', null, 'Rating = \'Cold\'');
        system.assertNotEquals(System.Label.NotificationValidationMatch, notificationmessage, 'Different message returned');

    }

}