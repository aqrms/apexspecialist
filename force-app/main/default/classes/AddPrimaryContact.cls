public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext qc) {
        
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<contact>();

        for (Account a : accounts) {
            Contact c = contact.clone();
            c.AccountId = a.Id;
            contacts.add(c);
        }
        insert contacts;
    }
    


}