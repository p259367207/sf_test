public class ParticipationService {

    public static List<Participation__c> getByCourse(String course) {
        return ParticipationDao.getByCourse(course);
    }
    
    public static List<Schema.PicklistEntry> getGradeList() {
        Schema.DescribeFieldResult fieldResult = Participation__c.Grade__c.getDescribe();
        return fieldResult.getPicklistValues();
    }
    
    public static void updateGrade(StudentDto dto) {
        Participation__c participation = ParticipationDao.getById(dto.getId(), dto.getCourseId());
        participation.Grade__c = dto.getGrade();
        ParticipationDao.updateGrade(participation);
    }
    
    public static void updateGrade(List<StudentDto> dtos) {
        for(StudentDto dto : dtos) {
            updateGrade(dto);
        }
    } 
}