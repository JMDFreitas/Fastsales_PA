import { LightningElement, wire, track, api } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";

export default class ProductScreen extends LightningElement {
    //@api recordId;
    @api products = [];
    @wire(CurrentPageReference) pagRef;

    selectHandler(event) {
        console.log("clicou");
        let valueCliked = event.target.id;
        console.log("Dados do event: " + JSON.stringify(valueCliked));

        const selectedEvent = new CustomEvent("selected", { detail: this.products[0] });

        console.dir("Evento selecionado: " + JSON.stringify(selectedEvent.detail));
        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
    }
}
