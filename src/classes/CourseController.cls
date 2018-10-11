public with sharing class CourseController {
    
    public String selectedCourse {get; set;}
    public List<SelectOption> courseList {get; set;}
    public List<SelectOption> gradeList {get; set;}
    
    public List<StudentDto> notGradedStudents {get; set;}
    public List<StudentDto> insuffStudents {get; set;}
    public List<StudentDto> gradedStudents {get; set;}
    
    public CourseController() {
        courseList = new List<SelectOption>();
        gradeList = new List<SelectOption>();
        
        courseList.add(new SelectOption('', ''));
        for(Course__c v : CourseService.getAll()){
            courseList.add(new SelectOption(v.Name__c, v.Name__c));
        }
        
        gradeList.add(new SelectOption('', ''));
        for(Schema.PicklistEntry pl : ParticipationService.getGradeList()) {
            gradeList.add(new SelectOption(pl.getValue(), pl.getLabel()));
        }
    }
    
    public void showStudents() {
        if(!String.isEmpty(selectedCourse)) {
            Map<String, List<StudentDto>> m = StudentService.getGroups(selectedCourse);
            notGradedStudents = m.get('1');
            insuffStudents = m.get('2');
            gradedStudents = m.get('3');
        } else {
            notGradedStudents = null;
            insuffStudents = null;
            gradedStudents = null;
        }
    }
    
    public void updateGrade() {
        if(notGradedStudents != null) {
            ParticipationService.updateGrade(notGradedStudents);
        }
        if(insuffStudents != null) {
            ParticipationService.updateGrade(insuffStudents);
        }
        showStudents();
    } 
}