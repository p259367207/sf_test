public class DependentPicklist {

    public static List<String> getValues() {
		List<String> result = new List<String>();

        Schema.DescribeFieldResult describe = Demo__c.Device__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = describe.getPicklistValues();

        for(Schema.PicklistEntry entry : picklistValues) {
            System.debug('label: ' + entry.getLabel() + ', value: ' + entry.getValue());
        }
        
        return result;
    }
}