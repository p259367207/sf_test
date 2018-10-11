//deadlock does not work
public class DemoExceptionFor10SecondsLock {

    @future
    public static void method1() {
        System.debug('started 1 - ' + Datetime.now());
        List<Demo__c> demo1 = [SELECT Id FROM Demo__c WHERE Id = 'a007F00000mVOjO' FOR UPDATE];

        for (Integer i = 0; i < 10000000; i++) {
        }

        List<Demo__c> demo2 = [SELECT Id FROM Demo__c WHERE Id = 'a007F00000mVOjP' FOR UPDATE];
        System.debug('finished 1 - ' + Datetime.now());
    }

    @future
    public static void method2() {
        System.debug('started 2 - ' + Datetime.now());
        List<Demo__c> demo1 = [SELECT Id FROM Demo__c WHERE Id = 'a007F00000mVOjP' FOR UPDATE];

        for (Integer i = 0; i < 10000000; i++) {
        }

        List<Demo__c> demo2 = [SELECT Id FROM Demo__c WHERE Id = 'a007F00000mVOjO' FOR UPDATE];
        System.debug('finished 2 - ' + Datetime.now());
    }
}

//DemoExceptionLockFor10Seconds.method1();
//DemoExceptionLockFor10Seconds.method2();