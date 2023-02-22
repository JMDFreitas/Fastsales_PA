public with sharing class LanguageGithubRepository {
    public class LanguageGithubRepositoryException extends Exception {
    }
    @future(callout=true)
    public static void createUpdateLanguageGithub(String language) {
        try {
            GithubDataService github = new GithubDataService();
            List<LanguageGithub__c> languages = new List<LanguageGithub__c>();
            GithubData githubDataObj = github.findLanguageInGithub(language);
            if (githubDataObj.items.isEmpty()) {
                return;
            }
            for (GithubData.Item item : githubDataObj.items) {
                LanguageGithub__c languageGit = new LanguageGithub__c(
                    Name = item.name,
                    Allow_Forking__c = item.allow_forking,
                    Archived__c = item.archived,
                    Created_At__c = Datetime.valueOfGMT(item.created_at.replaceAll('[a-zA-Z]', ' ')),
                    Default_Branch__c = item.default_branch,
                    Description__c = item.description,
                    Disabled__c = item.disabled,
                    Fork__c = item.fork,
                    Forks_Count__c = item.forks_count,
                    Full_Name__c = item.full_name,
                    GithubId__c = item.id,
                    Has_Downloads__c = item.has_downloads,
                    Has_Issues__c = item.has_issues,
                    Has_Pages__c = item.has_pages,
                    Has_Projects__c = item.has_projects,
                    Has_Wiki__c = item.has_wiki,
                    Html_Url__c = item.html_url,
                    Language__c = item.language,
                    Mirror_Url__c = item.mirror_url,
                    Open_Issues_Count__c = item.open_issues_count,
                    Pushed_At__c = Datetime.valueOfGMT(item.pushed_at.replaceAll('[a-zA-Z]', ' ')),
                    Stargazers_Count__c = item.stargazers_count,
                    Updated_At__c = Datetime.valueOfGMT(item.updated_at.replaceAll('[a-zA-Z]', ' ')),
                    Visibility__c = item.visibility,
                    Watchers_Count__c = item.watchers_count,
                    Web_Commit_Signoff_Required__c = item.web_commit_signoff_required,
                    License_Key__c = item.license != null ? item.license.key : null,
                    License_Node_Id__c = item.license != null ? item.license.node_id : null,
                    License_Spdx_Id__c = item.license != null ? item.license.spdx_id : null,
                    License_Url__c = item.license != null ? item.license.url : null
                );
                languages.add(languageGit);
            }
            upsert languages GithubId__c;
        } catch (Exception ex) {
            throw new LanguageGithubRepositoryException('Error: ' + ex.getMessage());
        }
    }

    public List<LanguageGithub__c> findLanguageGithubWhereLanguage(String language) {
        List<String> fields = new List<String>();
        Schema.FieldSet fieldSet = SObjectType.LanguageGithub__c.FieldSets.GithubLanguageFields;
        for (Schema.FieldSetMember f : fieldSet.getFields()) {
            fields.add(f.getFieldPath());
        }
        String fieldsToQuery = String.join(fields, ', ');
        String query = 'SELECT ' + fieldsToQuery + ' FROM LanguageGithub__c WHERE Language__c =: language ORDER BY Stargazers_Count__c';
        System.debug('query: ' + query);
        List<LanguageGithub__c> languages = Database.query(String.escapeSingleQuotes(query));
        System.debug('Lista ' + JSON.serializePretty(languages));
        return languages;
    }
}