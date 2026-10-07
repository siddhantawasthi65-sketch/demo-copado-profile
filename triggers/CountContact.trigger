trigger CountContact on Contact (after insert, after delete) {
    Set<Id> accIds = new Set<Id>();
        if (trigger.isInsert){
        for (Contact c : trigger.new) {
            if (c.AccountId != null) {
                accIds.add(c.AccountId);
            }
        }
    }
    if (trigger.isDelete) {
        for (Contact c : trigger.old) {
            if (c.AccountId != null) {
                accIds.add(c.AccountId);
            }
        }
    }
     List<Account> accList = [select Id, Contact_Count__c ,(select Id from Contacts)from Account
                              where Id IN :accIds];
     for (Account acc : accList) {
        acc.Contact_Count__c = acc.Contacts.size();
    }
    update accList;
}