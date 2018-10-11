public class DemoPagination2000Controller {

    private List<DemoForPagination2000Wrapper> wrappers;

    public ApexPages.StandardSetController controller {
        get {
            if (controller == null) {
                controller = new ApexPages.StandardSetController(Database.getQueryLocator([
                        SELECT Id, Name
                        FROM Demo__c
                        ORDER BY Name
                ]));
                controller.setPageSize(20);
            }
            return controller;
        }
        set;
    }

    public List<DemoForPagination2000Wrapper> getWrappers() {
        wrappers = new List<DemoForPagination2000Wrapper>();
        for (Demo__c d : (List<Demo__c>) controller.getRecords()) {
            wrappers.add(new DemoForPagination2000Wrapper(d));
        }
        return wrappers;
    }

    public PageReference process() {
        for (DemoForPagination2000Wrapper d : wrappers) {
            if (d.checked) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO, d.demo.Name));
            }
        }
        return null;
    }

    public Boolean hasNext {

        get {
            return controller.getHasNext();
        }
        set;
    }

    public Boolean hasPrevious {
        get {
            return controller.getHasPrevious();
        }
        set;
    }

    public Integer pageNumber {
        get {
            return controller.getPageNumber();
        }
        set;
    }

    public void first() {
        controller.first();
    }

    public void last() {
        controller.last();
    }

    public void previous() {
        controller.previous();
    }

    public void next() {
        controller.next();
    }

    public void cancel() {
        controller.cancel();
    }
}