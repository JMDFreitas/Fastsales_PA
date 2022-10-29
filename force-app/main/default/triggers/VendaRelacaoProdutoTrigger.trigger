trigger VendaRelacaoProdutoTrigger on VendaRelacaoProduto__c(after insert) {
    switch on Trigger.OperationType {
        when AFTER_INSERT {
            VendaRelacaoProdutoTriggerHandler.afterInsertHandler(Trigger.new);
        }
        when AFTER_UPDATE {
            // VendaRelacaoProdutoTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_DELETE {
            // VendaRelacaoProdutoTriggerHandler.afterDeleteHandler(Trigger.old);
        }
        when AFTER_UNDELETE {
            // VendaRelacaoProdutoTriggerHandler.afterUndeleteHandler(Trigger.new);
        }
        when BEFORE_INSERT {
            // VendaRelacaoProdutoTriggerHandler.beforeInsertHandler(Trigger.new);
        }
    }
}
