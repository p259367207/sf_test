public class CourseDao {

    public static List<Course__c> getAll() {
        return [SELECT Id, Name__c, Start_Date__c, End_Date__c, Enrolled_Students__c, Success_Ratio__c, Duration__c
                FROM Course__c];
    }

    public static Course__c getByName(String name) {
        List<Course__c> courses =
             [SELECT Id, Name__c, Start_Date__c, End_Date__c, Success_Ratio__c, Duration__c
             FROM Course__c WHERE Name__c = :name];
        if(courses.size() != 0) {
            return courses.get(0);
        }
        return null;
    }
}