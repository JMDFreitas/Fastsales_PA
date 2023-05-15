public with sharing class RezoneamentoService {
    private static Map<String, Type> objectToRezonear = new Map<String, Type>{
        'Account' => RezonearConta.class
        // 'Opportunity' => RezonearOportunidade.class,
        // 'OpportunityLineItem' => RezonearProduto.class
    };
    public static void rezonear(String objeto, Set<Id> centroIds) {
        IRezoneavel rezoneamento = (IRezoneavel) objectToRezonear.get(objeto).newInstance();
        rezoneamento.buscarObjetoRezoneavel(centroIds);
        rezoneamento.buscarCentros(centroIds);
        rezoneamento.rezonear();
    }
}
