/***********************************************************************
 * @Author: Johnny Freitas
 * Create Date: 29/07/2022
 * Purpose: Contémm os serviços referentes a integração com github
 * Versão: 1.0
 *************************************************************************/
public class GithubDataService {
    public class GithubDataServiceException extends Exception {
    }

    public GithubData findLanguageInGithub(String language) {
        GithubData ConvertedObj;
        try {
            Http http = new Http();

            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint('callout:Github/' + 'search/repositories?q=language:' + language + '&sort=stars&page=1');

            HttpResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                ConvertedObj = GithubData.parse(res.getBody());
                System.debug('Tamanho List: ' + ConvertedObj.items.size());
            }
        } catch (Exception ex) {
            throw new GithubDataServiceException('Error: ' + ex.getMessage());
        }
        return ConvertedObj;
        
    }
}