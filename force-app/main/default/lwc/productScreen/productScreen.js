import { LightningElement, api } from "lwc";

export default class ProductScreen extends LightningElement {
    @api recordId;
    @api products = [];

    selectHandler(event) {
        for (let produto of this.products) {
            console.dir("Dados do event: " + JSON.stringify(event.target.key));
            console.dir("Produto: " + JSON.stringify(produto));
        }

        const selectedEvent = new CustomEvent("selected", { detail: this.products[0] });

        console.dir("Evento selecionado: " + JSON.stringify(selectedEvent.detail));
        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    }
}
