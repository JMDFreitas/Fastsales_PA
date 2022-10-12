import { LightningElement, api } from "lwc";

export default class PdvScreen extends LightningElement {
    produtos = [];
    somaValores;
    @api
    set products(value) {
        if (value != undefined) {
            this.produtos.push(value);
        }
        this.total();
    }
    get products() {
        return this.produtos;
    }

    total() {
        return (this.somaValores = this.products
            .map((el) => el.preco)
            .reduce((acumulador, valorAtual) => acumulador + valorAtual, 0));
    }
}

/* 
import { CurrentPageReference } from "lightning/navigation";
import { registerListener, unregisterAllListeners } from "c/pubsub";
    @wire(CurrentPageReference) pagRef;
    connectedCallback() {
        registerListener("eventTest", this.handleCallback, this);
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
    }

    handleCallback(detail) {
        alert("Parameters from publisher: " + detail.nome);
    }
    
     {
            ativo: true,
            categoria: "Bebidas",
            codigoBarras: "1000001004",
            dataCriacao: "2022-10-01T17:52:38.000Z",
            id: "a075f000004EoXTAA0",
            nome: "Becks",
            preco: 4,
            qtd: 30
        }

        this.vetor = JSON.stringify(this.listdata.map((el) => el.preco));
        console.log("Vetor Map: " + this.vetor);
        const vetor2 = [...this.vetor];

        console.log(
            "Vetor 2: " +
                vetor2.
        );

        
    */
