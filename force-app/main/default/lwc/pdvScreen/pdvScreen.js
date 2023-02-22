import { LightningElement, api, track } from "lwc";
import createVenda from "@salesforce/apex/PdvScreenController.createVenda";
import createVendaRelacaoProduto from "@salesforce/apex/PdvScreenController.createVendaRelacaoProduto";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class PdvScreen extends LightningElement {
    @track produtos = [];
    somaValores;
    precoProductInsered;
    idsProdutos = [];
    idProduto;
    @track venda;
    newProducts = [];

    @api
    set products(value) {
        if (value != undefined) {
            this.precoProductInsered = value.preco;
            this.idProduto = value.id;
            this.produtos.push(value);
        }
        this.total();
    }
    get products() {
        return this.produtos;
    }

    total() {
        return (this.somaValores = this.produtos
            .map((el) => el.precoPorQtd)
            .reduce((acumulador, valorAtual) => acumulador + valorAtual, 0));
    }

    handleAmountChange(event) {
        action.setStorable();
        let qtdInsered = event.target.value;
        let precoPorQtd = this.precoProductInsered * qtdInsered;

        const prods = [];

        for (let item of this.produtos) {
            if (this.idProduto == item.id) {
                prods.push({ id: item.id, nome: item.nome, preco: item.preco, qtd: qtdInsered, precoPorQtd: precoPorQtd });
            } else {
                prods.push(item);
            }
        }

        this.produtos = [...prods];
        this.total();
    }

    finalizarVenda(event) {
        let descricao = "";
        for (let index = 0; index < this.produtos.length; index++) {
            descricao +=
                this.produtos[index].nome +
                " " +
                this.produtos[index].preco.toLocaleString("pt-br", { style: "currency", currency: "BRL" }) +
                " x " +
                this.produtos[index].qtd +
                " = " +
                this.produtos[index].precoPorQtd.toLocaleString("pt-br", { style: "currency", currency: "BRL" }) +
                "\n";
        }

        createVenda({ valorVenda: this.somaValores, descricao: descricao })
            .then((result) => {
                console.log("Result: " + JSON.stringify(result));
                if (result) {
                    this.venda = result;
                    console.log("Id: " + JSON.stringify(this.venda.Id));
                    this.showToast("Ótimo!", "Venda finalizada com sucesso", "success");
                    this.criarVendaRelacaoProduto();
                    //eval("$A.get('e.force:refreshView').fire();");
                }
            })
            .catch((error) => {
                console.log(error);
                console.error(error);
                if (error.status == 500) {
                    this.showToast("Atenção", "A venda não foi criada contate o administrador", "error");
                }
            });
    }

    criarVendaRelacaoProduto() {
        console.log("Entrou criarVendaRelacaoProduto! ");
        const registros = [];
        for (let index = 0; index < this.produtos.length; index++) {
            registros.push({
                RelacaoVenda__c: this.venda.Id,
                RelacaoProduto__c: this.produtos[index].id,
                QuantidadeVenda__c: this.produtos[index].qtd
            });
        }
        console.dir("Registros: " + JSON.stringify(registros));
        createVendaRelacaoProduto({ registros: registros })
            .then((result) => {
                console.log("Criou o VendaRelaProd");
            })
            .catch((error) => {
                this.showToast("Atenção", "Algum erro na Venda Relaçao Produto", "error");
            });
    }

    showToast(varTitle, varMessage, varVariant) {
        const event = new ShowToastEvent({
            title: varTitle,
            message: varMessage,
            variant: varVariant,
            mode: "pester"
        });

        this.dispatchEvent(event);
    }
}

/* 

for (let item of this.produtos) {
            console.log(`ITEM FOR ${JSON.stringify(item)}`);
            //item.precoPorQtd = precoPorQtd;
            console.log(`ITEM FOR ${JSON.stringify(item.precoPorQtd)}`);
        }
({
                id: String,
                nome: String,
                preco: Number,
                precoPorQtd: Number
            });
            // id = el.id;
            // nome = el.nome;
            // preco = preco;
            // precoPorQtd = 10;
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
