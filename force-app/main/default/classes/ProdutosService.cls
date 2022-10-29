public with sharing class ProdutosService {
    public static void updateQtdProduto(Map<Id, Decimal> idQtdMap) {
        List<Produto__c> produtosToUpdate = new List<Produto__c>();
        try {
            List<Produto__c> produtos = ProdutosRepository.getInstance().selectById(idQtdMap.keySet());
            for (Produto__c prod : produtos) {
                Produto__c produto = new Produto__c(Id = prod.Id, QTD__c = prod.QTD__c - idQtdMap.get(prod.Id));
                produtosToUpdate.add(produto);
            }
            Database.update(produtosToUpdate);
        } catch (Exception ex) {
            System.debug('Message: ' + ex.getMessage());
            System.debug('Stack: ' + ex.getStackTraceString());
        }
    }
}
