public with sharing class RezonearProduto implements IRezoneavel {
    public List<OpportunityLineItem> produtos { get; set; }
    public Map<Id, CentroDeLucro__c> idToCentro { get; set; }

    public void rezonear() {
        for (OpportunityLineItem prod : produtos) {
            prod.EquipeVendasProduto__c = idToCentro.get(prod.Opportunity.Account.CentroLucroConta__c).EquipeDeVendas__c;
            prod.Vendedor__c = idToCentro.get(prod.Opportunity.Account.CentroLucroConta__c).Owner.Name;
        }
        Database.update(produtos);
    }
}
