public class CourseService {

    public static List<Course__c> getAll() {
        return CourseDao.getAll();
    }
    
    public static Course__c getByName(String name) {
        return CourseDao.getByName(name);
    }
}