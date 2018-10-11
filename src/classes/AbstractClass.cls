public abstract class AbstractClass {

    private String field;

    public AbstractClass() {
        this.field = 'default';
    }

    public AbstractClass(String field) {
        this.field = field;
    }

    public void print() {
        System.debug('value: ' + field);
    }

    public abstract String sayHello();
}