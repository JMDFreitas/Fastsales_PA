import { LightningElement, wire, api } from "lwc";
import findProducts from "@salesforce/apex/ProductSearchController.findProdutosWhereCategoria";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

const DELAY = 3000;

export default class ProductSearch extends LightningElement {
    searchKey;
    products;

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.searchKey = evt.target.value;
            console.log("Searchkey " + JSON.stringify(this.searchKey));
            findProducts({ clause: "Categoria__c", filter: this.searchKey, orderBy: "CreatedDate" }).then((result) => {
                if (result.length === 0) {
                    this.showToast("Atenção", "Esta categoria não existe!", "warning");
                    return;
                }
                this.products = result;
                console.dir(this.products);
            });
        }
    }

    showToast(varTitle, varMessage, varVariant) {
        const event = new ShowToastEvent({
            title: varTitle,
            message: varMessage,
            variant: varVariant,
            mode: "sticky"
        });

        this.dispatchEvent(event);
    }
}
