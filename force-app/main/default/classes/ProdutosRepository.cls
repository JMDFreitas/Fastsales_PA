public inherited sharing class ProdutosRepository extends Repository {
    private static ProdutosRepository instance = null;

    public static ProdutosRepository getInstance() {
        if (instance == null) {
            instance = new ProdutosRepository();
        }
        return instance;
    }

    //Constructor
    private ProdutosRepository() {
        sObjType = Produto__c.getSObjectType();
        fieldSet = SObjectType.Produto__c.FieldSets.Repository;
    }
}