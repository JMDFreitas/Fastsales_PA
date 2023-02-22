import { LightningElement, wire } from "lwc";
import findProducts from "@salesforce/apex/fakeStoreApiController.findProducts";

export default class FakeStoreApi extends LightningElement {
    @wire(findProducts, {}) products;
}
