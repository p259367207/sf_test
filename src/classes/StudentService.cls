public class StudentService {
    
    public static Student__c getById(String studentId) {
        return StudentDao.getById(studentId);
    }
    
    public static Map<String, List<StudentDto>> getGroups(String courseName) {
        Map<String, List<StudentDto>> groups = new Map<String, List<StudentDto>>();
        
        List<StudentDto> gradedStudents = new List<StudentDto>();
        List<StudentDto> notGradedStudents = new List<StudentDto>();
        List<StudentDto> insuffStudents = new List<StudentDto>();
        
        if(!String.isEmpty(courseName)) {
            
            List<Participation__c> g = ParticipationService.getByCourse(courseName);
            Course__c course = CourseService.getByName(courseName);
            
            if(course != null) {
                Integer duration = (Integer) course.Duration__c;
                for(Participation__c p : g){
                    Student__c student = StudentService.getById(p.Student__c);
                    StudentDto dto = new StudentDto();
                    dto.setId(student.Id);
                    dto.setFullName(student.First_Name__c + ' ' + student.Last_Name__c);
                    dto.setCourseId(p.Course__c);
                    dto.setGrade(p.Grade__c);
                    Integer attendHours = (Integer) p.Hours_Attended__c;
                    
                    if(attendHours < 0.5 * duration && p.Grade__c == null) {
                        dto.setGrade('F');
                        insuffStudents.add(dto);
                    } else if(p.Grade__c == null) {
                        notGradedStudents.add(dto);
                    } else {
                        dto.setResult(isExamPassed(p.Grade__c));
                        gradedStudents.add(dto);
                    }
                }
                
            }
        }
        
        groups.put('1', notGradedStudents);
        groups.put('2', insuffStudents);
        groups.put('3', gradedStudents);
        
        return groups;
    }
    
    public static String isExamPassed(String grade) {
        if('A B C'.containsIgnoreCase(grade)) {
            return 'Pass';
        }
        return 'Fail';
    }
}