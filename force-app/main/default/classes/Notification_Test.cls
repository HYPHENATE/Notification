/**
 * @description       : Test class for Notification component
 * @author            : daniel@hyphen8.com
 * @last modified on  : 13-02-2024
 * @last modified by  : daniel@hyphen8.com
**/
@isTest
public class Notification_Test {
    

    /**
     * @description basic simple test
    */
    @isTest
    static void testcurrentrecordfield(){
        Account account = new Account(Name='TestAccount1');
        insert account;

        String notificationmessage = NotificationController.getMessage(account.Id, 'Account', 'Name', null);
        System.assertEquals('TestAccount1', notificationmessage, 'Different message returned');

    }

    /**
     * @description basic parent test
    */
    @isTest
    static void testparentrecordfield(){
        Account account = new Account(Name='TestAccount1');
        insert account;
        Contact contact = new Contact(LastName='TEST USER', AccountId=account.Id);
        insert contact;

        String notificationmessage = NotificationController.getMessage(contact.Id, 'Contact', 'Account.Name', null);
        System.assertEquals('TestAccount1', notificationmessage, 'Different message returned');

    }

    /**
     * @description error test
    */
    @isTest
    static void testerror(){
        Account account = new Account(Name='TestAccount1');
        insert account;
        Contact contact = new Contact(LastName='TEST USER', AccountId=account.Id);
        insert contact;

        String notificationmessage = NotificationController.getMessage(contact.Id, 'Contact', 'Email', null);
        System.assertEquals(System.Label.NotificationErrorProcessing, notificationmessage, 'Different message returned');

    }

    /**
     * @description error test parent field
    */
    @isTest
    static void testerrorparent(){
        Account account = new Account(Name='TestAccount1');
        insert account;
        Contact contact = new Contact(LastName='TEST USER', AccountId=account.Id);
        insert contact;

        string notificationmessage = NotificationController.getMessage(contact.Id, 'Contact', 'Account.NameINGERROR', null);
        System.assertEquals(System.Label.NotificationErrorProcessing, notificationmessage, 'Different message returned');

    }

    /**
     * @description query with where clause get a response
    */
    @isTest
    static void testSuccessWhereClause(){
        Account account = new Account(Name='TestAccount1', Rating='Hot');
        insert account;
        Contact contact = new Contact(LastName='TEST USER', AccountId=account.Id);
        insert contact;

        String notificationmessage = NotificationController.getMessage(account.Id, 'Account', null, 'Rating = \'Hot\'');
        System.assertEquals(System.Label.NotificationValidationMatch, notificationmessage, 'Different message returned');

    }

    /**
     * @description query with where clause get no response
    */
    @isTest
    static void testSuccessWhereClauseFail(){
        Account account = new Account(Name='TestAccount1', Rating='Hot');
        insert account;
        Contact contact = new Contact(LastName='TEST USER', AccountId=account.Id);
        insert contact;

        String notificationmessage = NotificationController.getMessage(account.Id, 'Account', null, 'Rating = \'Cold\'');
        System.assertNotEquals(System.Label.NotificationValidationMatch, notificationmessage, 'Different message returned');

    }

}