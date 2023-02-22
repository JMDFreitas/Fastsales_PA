public with sharing class GithubLanguageSelector extends Selector {
    private static GithubLanguageSelector instance { get; set; }

    private static GithubLanguageSelector getInstance() {
        if (instance == null) {
            instance = new GithubLanguageSelector();
        }
        return instance;
    }

    private GithubLanguageSelector() {
        sObjType = LanguageGithub__c.getSObjectType();
        fieldSet = SObjectType.LanguageGithub__c.FieldSets.GithubLanguageFields;
    }
}