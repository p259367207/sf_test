@RestResource(urlMapping = '/contact/*')
global class ContactController {

    public List<Contact> contacts { get; private set; }

    public List<Account> accs1 { get; set; }
    public List<Account> accs2 { get; set; }

    public PaginationUtil util { get; set; }

    public ContactController() {
        accs2 = new List<Account>();
    }

    public void updateContactList() {
        Map<String, String> parameters = ApexPages.currentPage().getParameters();
        Integer currentPage = PaginationUtil.parsePage(parameters.get('page'));
        Integer itemPerPage = PaginationUtil.parseSize(parameters.get('size'));
        Integer totalItemNumber = ContactService.getSize();

        util = new PaginationUtil(currentPage, totalItemNumber, itemPerPage, 5);
        contacts = ContactService.getContacts(currentPage - 1, itemPerPage);
    }

    @HttpGet
    global static void httpGetMethod() {
        RestContext.response.addHeader('Content-Type', 'application/json');

        String param = getUriParam();
        if (param == 'size') {
            RestContext.response.responseBody =
                    Blob.valueOf(JSON.serialize(ContactService.getSize()));
        } else {
            Id id = getIdFromRequest();
            List<Contact> contacts;
            if (id != null) {
                contacts = new List<Contact>();
                contacts.add(ContactService.getById(id));
            } else {
                Map<String, String> parameters = RestContext.request.params;
                Integer currentPage = PaginationUtil.parsePage(parameters.get('page'));
                Integer itemPerPage = PaginationUtil.parseSize(parameters.get('size'));
                contacts = ContactService.getContacts(currentPage - 1, itemPerPage);
            }
            //must be initialized for test
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(contacts));
        }
    }

    @HttpPost
    global static String post() {


        return null;
    }

    @HttpDelete
    global static void deleteContact() {
        Id id = getIdFromRequest();
        ContactService.deleteById(id);
    }

    @HttpPut
    global static void upsertContact() {
        String body = RestContext.request.requestBody.toString();
        List<Contact> contacts = (List<Contact>) JSON.deserialize(body, List<Contact>.class);
        ContactService.upsertObjects(contacts);
    }

    private static String getUriParam() {
        RestRequest restRequest = RestContext.request;
        String uri = restRequest.requestURI;
        List<String> strArray = uri.right(uri.length() - 1).split('/');
        if (strArray.size() == 2) {
            return strArray.get(1);
        }
        return null;
    }

    private static Id getIdFromRequest() {
        RestRequest restRequest = RestContext.request;
        String uri = restRequest.requestURI;
        List<String> strArray = uri.right(uri.length() - 1).split('/');
        if (strArray.size() == 2 && strArray.get(1) instanceof Id) {
            return strArray.get(1);
        }
        return null;
    }
}