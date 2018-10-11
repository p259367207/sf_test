@isTest
private class ParticipationDaoTest {
        
    @isTest
    static void testGetById() {
        Student__c s = TestDataUtil.getStudent1();
        Course__c c = TestDataUtil.getCourse1();
        insert s;
        insert c;
        Participation__c p = TestDataUtil.getParticipation1(s.Id, c.Id);
        insert p;
        
        Participation__c iP = ParticipationDao.getById(s.Id, c.Id);
        System.assertEquals(p.Grade__c, iP.Grade__c);
    }
    
    @isTest
    static void testGetByCourse() {
        Student__c s = TestDataUtil.getStudent1();
        Course__c c = TestDataUtil.getCourse1();
        insert s;
        insert c;
        Participation__c p = TestDataUtil.getParticipation1(s.Id, c.Id);
        insert p;
        
        List<Participation__c> l1 = ParticipationDao.getByCourse('cccc');
        System.assertEquals(0, l1.size());
        List<Participation__c> l2 = ParticipationDao.getByCourse(c.Name__c);
        System.assertEquals(1, l2.size());
    }
    
    @isTest
    static void testUpdateGrade() {
        Student__c s = TestDataUtil.getStudent2();
        Course__c c = TestDataUtil.getCourse2();
        insert s;
        insert c;
        Participation__c p = TestDataUtil.getParticipation2(s.Id, c.Id);
        insert p;
        
        String beforeUpdate = p.Grade__c;
        p.Grade__c = 'F';
        ParticipationDao.updateGrade(p);
        System.assertNotEquals(p.Grade__c, beforeUpdate);
    }
}