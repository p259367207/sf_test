public class DemoForPagination2000Wrapper {

    public Boolean checked { get; set; }
    public Demo__c demo { get; set; }

    public DemoForPagination2000Wrapper() {
        demo = new Demo__c();
        checked = false;
    }

    public DemoForPagination2000Wrapper(Demo__c demo) {
        this.demo = demo;
        checked = false;
    }
}