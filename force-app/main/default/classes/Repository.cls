public abstract class Repository {
    public Schema.SObjectType sObjType;
    public Schema.FieldSet fieldSet;

    public List<SObject> selectById(Set<Id> ids) {
        if (ids == null || ids.isEmpty()) {
            throw new EmptyIdsException('O parâmetro "ids" deve conter um Set<Id> não vazio');
        }

        String query = buildQuery();
        query += buildWhereClauseIdIn(ids);

        return Database.query(String.escapeSingleQuotes(query));
    }

    public List<SObject> selectByClauseOrderByDesc(String clause, String filter, String orderBy) {
        if (filter == null || String.isBlank(filter)) {
            throw new EmptyIdsException('O parâmetro "filter" deve conter uma string não vazia');
        } else if (clause == null || String.isBlank(clause)) {
            throw new RepositoryException('O parâmetro "clause" deve conter uma string não vazia');
        }

        string query = buildQuery();
        query += buildWhereClauseEqualsFilter(clause, filter);

        if (String.isNotBlank(orderBy)) {
            query += buildOrderByDesc(orderBy);
        }
        System.debug('QUERY' + query);
        return Database.query(String.escapeSingleQuotes(query));
    }
    public List<SObject> selectByClauseOrClause(String clause1, String clause2, String filter) {
        if (filter == null || String.isBlank(filter)) {
            throw new EmptyIdsException('O parâmetro "filter" deve conter uma string não vazia');
        } else if (clause1 == null || String.isBlank(clause1)) {
            throw new RepositoryException('O parâmetro "clause" deve conter uma string não vazia');
        } else if (clause2 == null || String.isBlank(clause2)) {
            throw new RepositoryException('O parâmetro "clause" deve conter uma string não vazia');
        }

        string query = buildQuery();
        query += buildWhereClauseEqualsFilter(clause1, filter) + ' OR ' + clause2 + ' =:filter';

        System.debug('QUERY' + query);
        return Database.query(String.escapeSingleQuotes(query));
    }

    public List<SObject> selectByIdWithChilds(Set<Id> ids, Set<Repository> instances) {
        if (ids == null || ids.isEmpty()) {
            throw new EmptyIdsException('O parâmetro "ids" deve conter um Set<Id> não vazio');
        } else if (instances == null || instances.isEmpty()) {
            throw new RepositoryException('O parâmetro "instances" deve conter um Set<Repository> não vazio');
        }

        String query = buildQueryWithChildRelationship(instances);
        query += buildWhereClauseIdIn(ids);

        System.debug('QUERY: ' + query);
        return Database.query(String.escapeSingleQuotes(query));
    }

    public List<SObject> selectAll() {
        return Database.query(buildQuery());
    }

    public String buildQuery() {
        String query = ' SELECT ';
        query += getFields(fieldSet);
        query += ' FROM ' + sObjType;

        return query;
    }

    public String buildQueryWithChildRelationship(Set<Repository> childsInstances) {
        String query = ' SELECT ';
        query += getFields(this.fieldSet);
        for (Repository childInstance : childsInstances) {
            query += buildRelationshipQuery(childInstance);
        }
        query += ' FROM ' + this.sObjType;

        return query;
    }

    private String getFields(Schema.FieldSet fieldSet) {
        String fields = '';
        for (Schema.FieldSetMember f : fieldSet.getFields()) {
            fields += f.getFieldPath() + ', ';
        }
        fields = fields.substringBeforeLast(',');

        return fields;
    }

    private String buildRelationshipQuery(Repository childInstance) {
        String query = '';

        if (childInstance.fieldSet != null) {
            String relationshipName = getRelationshipName(childInstance.sObjType);
            if (String.isNotBlank(relationshipName)) {
                query += ' , ( ';
                query += childInstance.buildRelationshipQuery(relationshipName);
                query += ' ) ';
            }
        }

        return query;
    }

    private String buildRelationshipQuery(String relationshipName) {
        String query = ' SELECT ';
        query += getFields(fieldSet);
        query += ' FROM ' + relationshipName;

        return query;
    }

    private String getRelationshipName(Schema.SObjectType childSObjectType) {
        for (Schema.ChildRelationship cr : this.sObjType.getDescribe().getChildRelationships()) {
            if (cr.getChildSObject() === childSObjectType) {
                return cr.getRelationshipName();
            }
        }

        return null;
    }

    public String buildWhereClauseIdIn(Set<Id> ids) {
        // corrigir oset de ids
        return ' WHERE Id IN :ids ';
    }

    public String buildWhereClauseEqualsFilter(String clause, String filter) {
        return ' WHERE ' + clause + ' =:filter';
    }

    public String buildWhereClauseLikeFilter(String clause, String filter) {
        filter = '\'%' + filter + '%\'';
        System.debug('filtro: ' + filter);
        return ' WHERE ' + clause + ' LIKE :filter';
    }

    public String buildOrderByDesc(String orderBy) {
        return ' ORDER BY ' + orderBy + ' DESC';
    }

    class RepositoryException extends Exception {
    }
}
