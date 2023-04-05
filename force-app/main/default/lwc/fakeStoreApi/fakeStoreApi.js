import { LightningElement, wire, track } from "lwc";
import findProducts from "@salesforce/apex/fakeStoreApiController.findProducts";

export default class FakeStoreApi extends LightningElement {
    @track items;
    @wire(findProducts)
    products({ error, data }) {
        if (data) {
            this.items = JSON.parse(data);
            console.log("data: " + JSON.stringify(this.items));
        } else if (error) {
            console.log("error" + error);
        }
    }
    //products;
    // connectedCallback() {
    //     findProducts()
    //         .then((result) => {
    //             this.products = JSON.parse(result);
    //             console.log("Result: " + JSON.stringify(this.products));
    //         })
    //         .catch((error) => {
    //             console.log("Error" + error);
    //         });
    // }
}
