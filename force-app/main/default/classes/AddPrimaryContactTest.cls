/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AddPrimaryContactTest {

    @TestSetup
    static void makeData(){
        
        List<Account> accounts = new List<Account>();
        
        for (Integer i = 0; i < 50; i++) {
            Account a = new Account(
                Name = 'Test' + i,
                BillingState = 'NY'
                );
            accounts.add(a);
        }
        for (Integer i = 0; i < 50; i++) {
            Account a = new Account(
                Name = 'Test' + i,
                BillingState = 'CA'
                );
            accounts.add(a);
        }

        insert accounts;
    }

    @isTest
    static void AddPrimaryContactTest() {
        Contact c = new Contact(LastName = 'Woo');
        String state = 'CA';

        Test.startTest();
        AddPrimaryContact apc = new AddPrimaryContact(c, state);
        Id jobId = System.enqueueJob(apc);
        Test.stopTest();

        List<Account> accts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE BillingState = :state];
        for (Account acc : accts) {
            System.assertEquals(1, acc.Contacts.size());
        }

    }
}