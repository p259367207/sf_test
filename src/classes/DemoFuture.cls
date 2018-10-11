public class DemoFuture {

	@future
	public static void increaseWithLock(Id recordId) {
		Demo__c d = [SELECT Id, int__c FROM Demo__c WHERE Id = :recordId FOR UPDATE];
		sleep(30000);
		d.int__c += 1;
		update d;
	}

	@future
	public static void increaseWithoutLock(Id recordId) {
		Demo__c d = [SELECT Id, int__c FROM Demo__c WHERE Id = :recordId];
		sleep(30000);
		d.int__c += 1;
		update d;
	}

    @future
    public static void prepareData(String fName, Boolean lock, Long milliseconds) {
        DateTime start = DateTime.now();
        List<Account> account;
        Id accountId = '0017F00000e7aZoQAI';
        if (lock) {
            account = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1 FOR UPDATE];
        } else {
            account = [SELECT Id FROM Account WHERE Id = :accountId LIMIT 1];
        }
        DateTime mid1 = Datetime.now();

//        update account;
        sleep(milliseconds);
        DateTime mid2 = Datetime.now();

        sleep(milliseconds);
        DateTime finish = DateTime.now();

        saveData(fName, start, mid1, mid2, finish);
    }

    public static void sleep(Long milliSeconds) {
        Long startTime = DateTime.now().getTime();
        Long finishTime = startTime;
        while ((finishTime - startTime) < milliSeconds) {
            finishTime = DateTime.now().getTime();
        }
    }

    public static void saveData(String fName, DateTime start, DateTime mid1, DateTime mid2, DateTime finish){
        FutureData__c fd = new FutureData__c(
                Name = fName,
                start__c = Time.newInstance(start.hour(), start.minute(), start.second(), start.millisecond()),
                mid1__c = Time.newInstance(mid1.hour(), mid1.minute(), mid1.second(), mid1.millisecond()),
                mid2__c = Time.newInstance(mid2.hour(), mid2.minute(), mid2.second(), mid2.millisecond()),
                finish__c = Time.newInstance(finish.hour(), finish.minute(), finish.second(), finish.millisecond())
        );
        insert fd;
    }

    public static void showReport(Long scale) {
        List<FutureData__c> futureData = [SELECT Name, start__c, mid1__c, mid2__c, finish__c FROM FutureData__c ORDER BY mid1__c];
        List<Time> timeData = new List<Time>();
        List<String> graph = new List<String>();

        for (FutureData__c ft : futureData) {
            graph.add(ft.Name + ' ');
            timeData.add(ft.start__c);
            timeData.add(ft.finish__c);
        }
        timeData.sort();

        Integer maxConcurrent = 0;
        for (Time t : timeData) {
            Integer countConcurrent = 0;
            for (Integer i = 0; i < futureData.size(); i++) {
                if (futureData.get(i).start__c <= t && t <= futureData.get(i).finish__c) {
                    countConcurrent += 1;
                }
            }
            maxConcurrent = Math.max(maxConcurrent, countConcurrent);
        }

        Date tmpDate = Date.newInstance(2018, 1, 1);
        Long start = Datetime.newInstance(tmpDate, timeData.get(0)).getTime();
        Long finish = Datetime.newInstance(tmpDate, timeData.get(timeData.size() - 1)).getTime();
        Long def = (finish - start) / scale;
        for (Integer d = 0; d <= def; d++) {
            for (Integer j = 0; j < futureData.size(); j++) {
                Long startFuture = (Datetime.newInstance(tmpDate, futureData.get(j).start__c).getTime() - start) / scale;
                Long mid1 = (Datetime.newInstance(tmpDate, futureData.get(j).mid1__c).getTime() - start) / scale;
                Long mid2 = (Datetime.newInstance(tmpDate, futureData.get(j).mid2__c).getTime() - start) / scale;
                Long finishFuture = (Datetime.newInstance(tmpDate, futureData.get(j).finish__c).getTime() - start) / scale;

                if (startFuture <= d && d < mid1) {
                    graph.set(j, graph.get(j) + '-');
                } else if (mid1 <= d && d < mid2) {
                    graph.set(j, graph.get(j) + '.');
                } else if (mid2 <= d && d <= finishFuture) {
                    graph.set(j, graph.get(j) + '*');
                } else {
                    graph.set(j, graph.get(j) + ' ');
                }
            }
        }

        String result = '\n   Maximum concurrent number of future methods = ' + maxConcurrent;
        for (String str : graph) {
            result += '\n' + str;
        }
        System.debug(result);
    }

    public static void clearFutureData() {
        List<FutureData__c> futureData = [SELECT Id FROM FutureData__c LIMIT 10000];
        delete futureData;
    }

    public static void createFutureDate(Integer dataSize) {
        Long sleepMillisec = 100;
        for (Integer i = 0; i < dataSize; i++) {
            String fieldNum = 'f-' + ('0' + i).right(2);
            if (Math.mod(i, 2) == 0) {
                prepareData(fieldNum + ' lock) ', true, sleepMillisec);
            } else {
                prepareData(fieldNum + '     ) ', false, sleepMillisec);
            }

//            saveFutureData(fieldNum + ' lock) ', true, sleepMillisec);

//            saveFutureData(fieldNum + '     ) ', false, sleepMillisec);
        }

    }
}

//DemoFuture.clearFutureData();
//DemoFuture.createFutureDate(8);

//DemoFuture.showReport(10);