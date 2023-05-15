public with sharing class RezonearOportunidade implements IRezoneavel {
    public List<Opportunity> opps;
    public Map<Id, CentroDeLucro__c> idToCentro;

    public void buscarObjetoRezoneavel(Set<Id> ids) {
        OpportunityRepository repos = new OpportunityRepository();
        this.opps = repos.buscarOppsPorCentros(ids);
    }

    public void buscarCentros(Set<Id> ids) {
        CentroDeLucroRepository repos = new CentroDeLucroRepository();
        this.idToCentro = new Map<Id, CentroDeLucro__c>(repos.buscarCentrosPorId(ids));
    }

    public void rezonear() {
        for (Opportunity opp : opps) {
            opp.CentroLucroOportunidade__c = idToCentro.get(opp.Account.CentroLucroConta__c).Name;
            opp.EquipeVendasOportunidade__c = idToCentro.get(opp.Account.CentroLucroConta__c).EquipeDeVendas__c;
            opp.OwnerId = idToCentro.get(opp.Account.CentroLucroConta__c).OwnerId;
        }
        Database.update(opps);
    }
}
