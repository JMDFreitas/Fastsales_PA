import { LightningElement } from "lwc";

export default class PdvScreen extends LightningElement {
    produtos = [
        { Name: "PD1", Preco: 2, QTD: 10, Id: 1 },
        { Name: "PD2", Preco: 5, QTD: 105, Id: 2 },
        { Name: "PD3", Preco: 1, QTD: 14, Id: 3 },
        { Name: "PD4", Preco: 12, QTD: 33, Id: 4 },
        { Name: "PD5", Preco: 22, QTD: 22, Id: 5 }
    ];
}
