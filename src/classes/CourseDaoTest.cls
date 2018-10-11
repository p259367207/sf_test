@isTest
private class CourseDaoTest {
	
    @isTest
    static void testGetAll() {
        Course__c c = TestDataUtil.getCourse1();
        
        System.assertEquals(0, CourseDao.getAll().size());
        insert c;
        System.assertEquals(1, CourseDao.getAll().size());
    }
    
	@isTest
    static void testGetByName() {
        Course__c c = TestDataUtil.getCourse1();
        
        System.assert(CourseDao.getByName(c.Name__c) == null);
        insert c;
        System.assert(CourseDao.getByName(c.Name__c) != null);
    }   
}