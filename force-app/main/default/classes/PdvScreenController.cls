public with sharing class PdvScreenController {
    @AuraEnabled
    public static Venda__c createVenda(Integer valorVenda, String descricao) {
        try {
            Venda__c venda = new Venda__c(ValorVenda__c = valorVenda, descricao__c = descricao);
            insert venda;
            return venda;
        } catch (DMLException e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void createVendaRelacaoProduto(list<VendaRelacaoProduto__c> registros) {
        try {
            insert (registros);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
