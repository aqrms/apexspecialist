public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(
        Integer num,
        String lastName
    ) {
        List<Contact> ctts = new List<Contact>();

        for (Integer i = 0; i < num; i++) {
            Contact c = new Contact(
                FirstName = 'Test' + i,
                LastName = lastName
            );
            ctts.add(c);
        }
        return ctts;
    }
}
