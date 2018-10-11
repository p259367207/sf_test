public class ContactDao {

    public static Contact getById(Id contactId) {
        List<Contact> contacts = [
                SELECT Id, Name, Phone, Email
                FROM Contact
                WHERE Id = :contactId
        ];
        if (contacts.size() == 1) {
            return contacts.get(0);
        }
        return null;
    }

    public static List<Contact> getContacts(Integer page, Integer size) {
        Integer offsetRec = page * size;
        List<Contact> contacts = [
                SELECT Id, Name, Phone, Email
                FROM Contact
                LIMIT :size
                OFFSET :offsetRec
        ];
        return contacts;
    }

    public static void upsertObject(List<Contact> contacts) {
        upsert contacts;
    }

    public static void deleteByObjects(List<Contact> contacts) {
        delete contacts;
    }

    public static Integer getSize() {
        return [SELECT COUNT() FROM Contact];
    }
}