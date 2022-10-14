import { LightningElement, api } from "lwc";
import createVenda from "@salesforce/apex/PdvScreenController.createVenda";

export default class PdvScreen extends LightningElement {
    produtos = [];
    somaValores;
    precoProductInsered;
    newProducts = [];

    @api
    set products(value) {
        if (value != undefined) {
            this.precoProductInsered = value.preco;
            //
            this.produtos.push(value);
        }
        this.total();
    }
    get products() {
        return this.produtos;
    }

    total() {
        return (this.somaValores = this.produtos
            .map((el) => el.preco)
            .reduce((acumulador, valorAtual) => acumulador + valorAtual, 0));
    }

    handleAmountChange(event) {
        let qtdInsered = event.target.value;
        let precoPorQtd = this.precoProductInsered * qtdInsered;
        //this.products[0].precoPorQtd;
        // console.log("Mutl: " + precoPorQtd);
        console.dir("Produtos: " + JSON.stringify(this.produtos));
        console.dir("precoPorQtd: " + JSON.stringify(this.produtos[0].precoPorQtd));
    }

    finalizarVenda(event) {
        let descricao;
        for (let index = 0; index < this.produtos.length; index++) {
            descricao = +this.produtos[index].nome + ";";
        }
        console.log("Descrição: " + descricao);
        createVenda({ valorVenda: this.somaValores, descricao: "descricao" }).then((result) => {
            console.log("Entrou no createVendas");
        });
    }
}

/* 
import { CurrentPageReference } from "lightning/navigation";
import { registerListener, unregisterAllListeners } from "c/pubsub";
    @wire(CurrentPageReference) pagRef;
    connectedCallback() {
        registerListener("eventTest", this.handleCallback, this);
    }
    console.dir("Produtos: " + JSON.stringify(this.products));
       

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
this.newProducts = this.products.map((el) => {
            ({
                id: el.id,
                nome: el.nome,
                preco: el.preco,
                precoPorQtd: 8
            });
        });
        console.dir("Novos Produtos: " + this.newProducts);
        console.dir("Novos Produtos: " + JSON.stringify(this.newProducts));
        
    */
