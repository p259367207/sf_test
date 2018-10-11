@isTest
private class StudentDaoTest {

    @isTest
    static void testGetById() {
       Student__c s = TestDataUtil.getStudent1();
       insert s;
       System.assert(StudentDao.getById('test') == null); 
       System.assert(StudentDao.getById(s.Id) != null); 
    }
}