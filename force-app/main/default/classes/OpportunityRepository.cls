public with sharing class OpportunityRepository {
    public List<Opportunity> buscarOppsPorCentros(Set<Id> centroIds) {
        return [SELECT Id, Account.CentroLucroConta__c FROM Opportunity WHERE Account.CentroLucroConta__c IN :centroIds];
    }
}
