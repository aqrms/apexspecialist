@isTest
public class AccountProcessorTest {
    @testSetup
    static void setup() {
        // Create test Accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;

        // Create test Contacts
        List<Contact> testContacts = new List<Contact>();
        for (Account acc : testAccounts) {
            for (Integer j = 0; j < 3; j++) {
                testContacts.add(
                    new Contact(
                        FirstName = 'Test',
                        LastName = 'Contact ' + j,
                        AccountId = acc.Id
                    )
                );
            }
        }
        insert testContacts;
    }

    @isTest
    static void testCountContacts() {
        List<Account> accts = [SELECT Id FROM Account];
        List<Id> acctIds = new List<Id>();

        for (Account acc : accts) {
            acctIds.add(acc.Id);
        }

        Test.startTest();
        AccountProcessor.countContacts(acctIds);
        Test.stopTest();

        List<Account> updatedAccts = [
            SELECT Id, Number_of_Contacts__c
            FROM Account
        ];
        for (Account acc : updatedAccts) {
            System.assertEquals(
                3,
                acc.Number_Of_Contacts__c,
                'Each account should have 3 contacts'
            );
        }
    }
}
