public with sharing class OpportunityLineItemRepository {
    public List<OpportunityLineItem> buscarProdutosPorCentros(Set<Id> centroIds) {
        return [
            SELECT Id, Opportunity.Account.CentroLucroConta__c
            FROM OpportunityLineItem
            WHERE Opportunity.Account.CentroLucroConta__c IN :centroIds
        ];
    }
}
