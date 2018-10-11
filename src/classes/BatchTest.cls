global class BatchTest implements Database.Batchable<Contact>{

    global Iterable<Contact> start(Database.BatchableContext info) {
        List<Contact> contacts = [SELECT Id FROM Contact];
        return contacts;
    }

    global void execute(Database.BatchableContext info, List<Contact> contacts) {
        Id recordId = 'a007F00000mVQ1sQAG';
        Long sleepTime = 100;

        DateTime start = DateTime.now();
        Demo__c d = [SELECT Id, int__c FROM Demo__c WHERE Id = :recordId];

        DateTime mid1 = Datetime.now();

        DemoFuture.sleep(sleepTime);
        d.int__c += contacts.size();
        DateTime mid2 = Datetime.now();

        DemoFuture.sleep(sleepTime);
        update  d;
        DateTime finish = DateTime.now();

        saveData('batch', start, mid1, mid2, finish);
    }

    global void finish(Database.BatchableContext info) {

    }

    private static void saveData(String fName, DateTime start, DateTime mid1, DateTime mid2, DateTime finish){
        FutureData__c fd = new FutureData__c(
                Name = fName,
                start__c = Time.newInstance(start.hour(), start.minute(), start.second(), start.millisecond()),
                mid1__c = Time.newInstance(mid1.hour(), mid1.minute(), mid1.second(), mid1.millisecond()),
                mid2__c = Time.newInstance(mid2.hour(), mid2.minute(), mid2.second(), mid2.millisecond()),
                finish__c = Time.newInstance(finish.hour(), finish.minute(), finish.second(), finish.millisecond())
        );
        insert fd;
    }
}