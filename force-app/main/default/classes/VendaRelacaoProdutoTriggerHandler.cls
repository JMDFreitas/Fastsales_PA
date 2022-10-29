public with sharing class VendaRelacaoProdutoTriggerHandler {
    public static void afterInsertHandler(List<VendaRelacaoProduto__c> vendasRelacaoProdutos) {
        // Guardar o Id do produto e a quantidade gast na venda
        Map<Id, Decimal> idQtdMap = new Map<Id, Decimal>();

        for (VendaRelacaoProduto__c registro : vendasRelacaoProdutos) {
            idQtdMap.put(registro.RelacaoProduto__c, registro.QuantidadeVenda__c);
        }
        System.debug(idQtdMap);
        ProdutosService.updateQtdProduto(idQtdMap);
    }
}
