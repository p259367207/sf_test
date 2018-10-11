@isTest
public class TestForTest {

    @TestSetup
    public static void prepareData() {
        User u;
        Account a;
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
            UserRole r = [SELECT Id FROM UserRole WHERE Name = 'COO'];
            u = new User(alias = 'jsmith',
                    email = 'test@test.by',
                    emailencodingkey = 'UTF-8',
                    lastname = 'Smith',
                    languagelocalekey = 'en_US',
                    localesidkey = 'en_US',
                    profileid = p.Id,
                    userroleid = r.Id,
                    timezonesidkey = 'America/Los_Angeles',
                    username = 'test.user@tp.com');
            insert u;
            a = new Account(name = 'Acme');
            insert a;
        }
    }

    @isTest
    public static void testSomething() {

    }
}