import { LightningElement, api } from "lwc";

export default class ProductTile extends LightningElement {
    @api product;

    handlePropertySelected() {
        const selectedEvent = new CustomEvent("selected", {
            detail: this.property.id
        });
        this.dispatchEvent(selectedEvent);
    }

    get backgroundImageStyle() {
        return `background-image:url(${this.product.image})`;
    }
}
