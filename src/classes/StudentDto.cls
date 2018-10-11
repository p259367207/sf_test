public class StudentDto{

    private String id;
    private String fullName;
    private String courseId;
    private String grade;
    private String result;
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getCourseId() {
        return courseId;
    }
    
    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }
    
    public String getGrade() {
        return grade;
    }
    
    public void setGrade(String grade) {
        this.grade= grade;
    }
    
    public String getResult() {
        return result;
    }
    
    public void setResult(String result) {
        this.result= result;
    } 
}