public class StudentDao {

    public static Student__c getById(String studentId) {
        List<Student__c> students = [SELECT Id, First_Name__c, Last_Name__c FROM Student__c WHERE Id = :StudentId];
        if(students.size() == 0) {
            return null;
        } 
        return students.get(0);
    }
}