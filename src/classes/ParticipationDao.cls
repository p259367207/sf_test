public class ParticipationDao {
    
    public static Participation__c getById (String studentId, String courseId) {
        Participation__c participation = 
            [SELECT Student__c, Course__c, Grade__c, Hours_Attended__c
             FROM Participation__c 
             WHERE Course__c = :courseId AND Student__c = :studentId];
        return participation;
    }
    
    public static List<Participation__c> getByCourse(String course) {
        List<Participation__c> participations = 
            [SELECT Student__c, Course__c, Grade__c, Hours_Attended__c
             FROM Participation__c 
             WHERE Course__c IN 
             (SELECT Id FROM Course__c WHERE Name__c = :course)];
        if(participations.size() != 0) {
            return participations;
        }
        return new List<Participation__c>();
    }
    
    public static void updateGrade(Participation__c participation) {
        update participation;
    }
}