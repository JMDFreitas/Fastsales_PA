public with sharing class RezonearConta implements IRezoneavel {
    List<Account> contas;
    Map<Id, CentroDeLucro__c> idToCentro;

    public void buscarObjetoRezoneavel(Set<Id> ids) {
        AccountRepository repos = new AccountRepository();
        this.contas = repos.buscarContasPorCentros(ids);
    }

    public void buscarCentros(Set<Id> ids) {
        CentroDeLucroRepository repos = new CentroDeLucroRepository();
        this.idToCentro = new Map<Id, CentroDeLucro__c>(repos.buscarCentrosPorId(ids));
    }

    public void rezonear() {
        for (Account acc : contas) {
            acc.EquipeVendasConta__c = idToCentro.get(acc.CentroLucroConta__c).EquipeDeVendas__c;
            acc.OwnerId = idToCentro.get(acc.CentroLucroConta__c).OwnerId;
        }
        Database.update(contas);
    }
}
