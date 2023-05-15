public with sharing class CentroDeLucroRepository {
    public List<CentroDeLucro__c> buscarCentrosPorId(Set<Id> ids) {
        return [SELECT Id, Name, EquipeDeVendas__c, OwnerId, Owner.Name FROM CentroDeLucro__c WHERE Id IN :ids];
    }
}
