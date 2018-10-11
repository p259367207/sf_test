@isTest
private class CourseServiceTest {

    @isTest
    static void testGetAll(){
        System.assertEquals(0, CourseService.getAll().size());
        Course__c c = TestDataUtil.getCourse1();
        insert c;
        System.assertEquals(1, CourseService.getAll().size());
    }
}