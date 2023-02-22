@isTest
public class AccountRepositoryTest {
    @TestSetup
    private static void makeData() {
        //List<SObject> accounts = Test.loadData(Account.SObjectType, 'AccountDataTest');
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 3; i++) {
            Account acct = new Account(
                Name = 'Test ' + i,
                Website = 'http://www.sforcetest1.com',
                Phone = '(415) 901-7000',
                BillingStreet = 'The Landmark @ One Market',
                BillingCity = 'San Francisco',
                BillingState = 'CA',
                BillingPostalCode = '94106',
                BillingCountry = 'US',
                CPF__C = '0010020030' + i
            );
            accounts.add(acct);
        }
        insert accounts;
    }
    @isTest
    private static void SelectTestReturnData() {
        List<Account> accounts = [SELECT Id FROM Account];
        System.debug('Id: ' + accounts[0].Id);
        System.assert(accounts.size() == 3, 'Expected 3 accounts');
    }
}
