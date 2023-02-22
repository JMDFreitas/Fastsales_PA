public with sharing class fakeStoreApiController {
    public fakeStoreApiController() {
    }

    @AuraEnabled(cacheable=true)
    public static FakeStoreApiData findProducts() {
        FakeStoreApiData items;
        try {
            items = IntegrationFakeStoreApiServices.findProductsInFakeStoreApi();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return items;
    }
}
