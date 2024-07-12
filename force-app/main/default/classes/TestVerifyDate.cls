@isTest
public class TestVerifyDate {
    @isTest
    static void test1() {
        Date result = VerifyDate.checkDates(
            Date.newInstance(2024, 7, 10),
            Date.newInstance(2024, 7, 11)
        );
        System.assertEquals(result, Date.newInstance(2024, 7, 11));
    }

    @isTest
    static void test2() {
        Date result = VerifyDate.checkDates(
            Date.newInstance(2024, 7, 10),
            Date.newInstance(2024, 8, 11)
        );
        System.assertEquals(result, Date.newInstance(2024, 7, 31));
    }
}