public class ContactService {

    public static Contact getById(Id contactId) {
        return ContactDao.getById(contactId);
    }

    public static List<Contact> getContacts(Integer page, Integer size) {
        return ContactDao.getContacts(page, size);
    }

    public static void upsertObject(Contact contact) {
        List<Contact> contacts = new List<Contact>();
        contacts.add(contact);
        upsertObjects(contacts);
    }

    public static void upsertObjects(List<Contact> contacts) {
        ContactDao.upsertObject(contacts);
    }

    public static void deleteByObject(Contact contact) {
        List<Contact> contacts = new List<Contact>();
        contacts.add(contact);
        deleteObjects(contacts);
    }

    public static void deleteObjects(List<Contact> contacts) {
        ContactDao.deleteByObjects(contacts);
    }

    public static void deleteById(Id contactId) {
        Contact contact = ContactDao.getById(contactId);
        if (contact != null) {
            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);
            ContactDao.deleteByObjects(contacts);
        }
    }

    public static Integer getSize() {
        return ContactDao.getSize();
    }
}