public with sharing class AccountRepository {
    public List<Account> buscarContasPorCentros(Set<Id> centroIds) {
        return [SELECT Id, CentroLucroConta__c FROM Account];
    }
}
