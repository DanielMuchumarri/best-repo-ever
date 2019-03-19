public with sharing class AccountController {
    public static List<Account> getAllActiveAccounts(){
        return [SELECT Id,Name,Active__c FROM Account where Active__c = 'Yes'];
    }
}