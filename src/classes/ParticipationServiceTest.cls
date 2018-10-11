@isTest
private class ParticipationServiceTest {
    
    @isTest
    static void testGradeList() {
        List<Schema.PicklistEntry> l = ParticipationService.getGradeList();
        System.assertEquals(6, l.size());
    }
        
    @isTest
    static void testUpdateGrade() {
        Student__c s1 = TestDataUtil.getStudent1();       
        Course__c c = TestDataUtil.getCourse1();
        insert s1;
        insert c;
        Participation__c p1 = TestDataUtil.getParticipation1(s1.Id, c.Id);
        insert p1;
        
        Map<String, List<StudentDto>> g1 = StudentService.getGroups(c.Name__c);
        
        System.assertEquals(1, g1.get('3').size());        
        StudentDto dto = g1.get('3').get(0);
		dto.setGrade('');
		List<StudentDto> lst = new List<StudentDto>();
        lst.add(dto);
        
        ParticipationService.updateGrade(lst); 
        
        g1 = StudentService.getGroups(c.Name__c);
        System.assertEquals(0, g1.get('3').size());   
    }
}