public with sharing class fakeStoreApiController {
    public fakeStoreApiController() {
    }

    @AuraEnabled(cacheable=true)
    public static String findProducts() {
        String items;
        try {
            items = IntegrationFakeStoreApiServices.findProductsInFakeStoreApi();

            System.debug('Retorno: ' + items);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return items;
    }
}
