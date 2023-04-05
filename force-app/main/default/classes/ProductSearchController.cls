public with sharing class ProductSearchController {
    @AuraEnabled(Cacheable=true)
    public static List<ProductWrapper> findProdutosWhereCategoria(String clause1, String clause2, String filter) {
        List<ProductWrapper> productsWrapper = new List<ProductWrapper>();

        try {
            List<Produto__c> produtos = ProdutosRepository.getInstance().selectByClauseOrClause(clause1, clause2, filter);
            for (Produto__c produto : produtos) {
                ProductWrapper produtWrapper = new ProductWrapper();
                produtWrapper.id = produto.Id;
                produtWrapper.nome = produto.Name;
                produtWrapper.preco = produto.Preco__c;
                produtWrapper.codigoBarras = produto.CodigoBarras__c;
                produtWrapper.qtd = 1;
                produtWrapper.ativo = produto.Ativo__c;
                produtWrapper.categoria = produto.Categoria__c;
                produtWrapper.dataCriacao = produto.CreatedDate;
                produtWrapper.precoPorQtd = (produtWrapper.preco * produtWrapper.qtd);
                productsWrapper.add(produtWrapper);
            }
            return productsWrapper;
        } catch (Exception e) {
            System.debug('Message: ' + e.getMessage());
            System.debug('Cause: ' + e.getCause());
            System.debug('Stack Trace: ' + e.getStackTraceString());
            System.debug('Type Name: ' + e.getTypeName());
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class ProductWrapper {
        @AuraEnabled
        public String id { get; set; }
        @AuraEnabled
        public String nome { get; set; }
        @AuraEnabled
        public Decimal preco { get; set; }
        @AuraEnabled
        public Decimal precoPorQtd { get; set; }
        @AuraEnabled
        public String codigoBarras { get; set; }
        @AuraEnabled
        public Decimal qtd { get; set; }
        @AuraEnabled
        public Boolean ativo { get; set; }
        @AuraEnabled
        public String categoria { get; set; }
        @AuraEnabled
        public Datetime dataCriacao { get; set; }
    }
}
