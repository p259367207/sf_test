public class DemoController {

    public String lastName { get; set; }
    public Integer amount { get; set; }
    public Integer price { get; private set; }
    public Integer total { get; set; }

    public DemoController() {
        price = 1200;
    }

    public void updateValue(){
        if(amount > 0 && price > 0) {
            total = amount * price;
        } else {
            total = null;
        }
    }

    public void save() {
        System.debug(lastName);
    }
}