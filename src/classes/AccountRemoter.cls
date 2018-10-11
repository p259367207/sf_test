global with sharing class AccountRemoter {

    @RemoteAction
    global static String getGretting() {
        return 'Hello from account remoter!';
    }
}