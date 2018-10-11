@isTest
private class StudentDtoTest {
    
    @isTest
    static void testId(){
        String val = 'test';
        StudentDto s = new StudentDto();
        s.setId(val);
        System.assertEquals(val, s.getId());
    }
    
    @isTest
    static void testFullName(){
        String val = 'test';
        StudentDto s = new StudentDto();
        s.setFullName(val);
        System.assertEquals(val, s.getFullName());
    }
    
    @isTest
    static void testCourseId(){
        String val = 'test';
        StudentDto s = new StudentDto();
        s.setCourseId(val);
        System.assertEquals(val, s.getCourseId());
    }
    
    @isTest
    static void testGrade(){
        String val = 'test';
        StudentDto s = new StudentDto();
        s.setGrade(val);
        System.assertEquals(val, s.getGrade());
    }
    
    @isTest
    static void testResult(){
        String val = 'test';
        StudentDto s = new StudentDto();
        s.setResult(val);
        System.assertEquals(val, s.getResult());
    }
}