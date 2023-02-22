public with sharing class IntegrationFakeStoreApiServices {
    public IntegrationFakeStoreApiServices() {
    }
    public class IntegrationFakeStoreApiServicesException extends Exception {
    }

    public static FakeStoreApiData findProductsInFakeStoreApi() {
        FakeStoreApiData items;
        try {
            Http http = new Http();

            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('callout:AcessFakeStore/' + 'products');

            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                String json = '{"items":' + res.getBody() + '}';
                //System.debug('Retorno: ' + json);
                items = FakeStoreApiData.parse(json);
                System.debug('Retorno: ' + items);
            }
            if (res.getStatusCode() != 200) {
                throw new IntegrationFakeStoreApiServicesException(
                    'ERROR STATUS CODE: ' +
                    res.getStatusCode() +
                    ' ERROR CODE: ' +
                    res.getStatus()
                );
            }
        } catch (Exception ex) {
            System.debug('ERROR: ' + ex.getMessage());
        }
        return items;
    }
}
