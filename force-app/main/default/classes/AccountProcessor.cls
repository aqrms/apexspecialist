public class AccountProcessor {
    @future
    public static void countContacts(List<Id> acctIds) {
        AggregateResult[] result = [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :acctIds
            GROUP BY AccountId
        ];

        List<Account> acctsToUpdate = new List<Account>();
        for (AggregateResult a : result) {
            Account acc = new Account(
                Id = (Id) a.get('AccountId'),
                Number_Of_Contacts__c = (Integer) a.get('contactCount')
            );
            acctsToUpdate.add(acc);
        }

        if (!acctsToUpdate.isEmpty()) {
            update acctsToUpdate;
        }
    }
}