@isTest
private class StudentServiceTest {
    
    @isTest
    static void testGetById() {
        Student__c s = TestDataUtil.getStudent2();
        insert s;
        
        System.assert(StudentService.getById('test') == null);
        System.assert(StudentService.getById(s.Id) != null);
    }
    
    @isTest
    static void testGetGroups() {
        Student__c s1 = TestDataUtil.getStudent1();
        Student__c s2 = TestDataUtil.getStudent2();
        Student__c s3 = TestDataUtil.getStudent3();
        
        Course__c c = TestDataUtil.getCourse1();
        
        insert s1;
        insert s2;
        insert s3;
        insert c;
        
        Participation__c p1 = TestDataUtil.getParticipation1(s1.Id, c.Id);
        Participation__c p2 = TestDataUtil.getParticipation2(s2.Id, c.Id);
        Participation__c p3 = TestDataUtil.getParticipation3(s3.Id, c.Id);
        
        insert p1;
        insert p2;
        insert p3;
        
        Map<String, List<StudentDto>> g1 = StudentService.getGroups(c.Name__c);
        System.assertEquals(1, g1.get('1').size());
        System.assertEquals(1, g1.get('2').size());
        System.assertEquals(1, g1.get('3').size());
        
        Map<String, List<StudentDto>> g2 = StudentService.getGroups('any');
        System.assertEquals(0, g2.get('1').size());
        System.assertEquals(0, g2.get('2').size());
        System.assertEquals(0, g2.get('3').size());
    }
        
    @isTest
    static void testIsExamPassed(){
        String pass = 'Pass';
        String fail = 'Fail';
        System.assertEquals(pass, StudentService.isExamPassed('A'));
        System.assertEquals(pass, StudentService.isExamPassed('B'));
        System.assertEquals(pass, StudentService.isExamPassed('C'));
        System.assertEquals(fail, StudentService.isExamPassed('D'));
        System.assertEquals(fail, StudentService.isExamPassed('E'));
        System.assertEquals(fail, StudentService.isExamPassed('F'));
    }
}