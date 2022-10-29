import { LightningElement } from "lwc";
import findProducts from "@salesforce/apex/ProductSearchController.findProdutosWhereCategoria";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ProductSearch extends LightningElement {
    searchKey;
    products;

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;

        if (isEnterKey) {
            this.searchKey = evt.target.value;

            findProducts({ clause1: "Name", clause2: "CodigoProduto__c", filter: this.searchKey })
                .then((result) => {
                    if (result.length === 0) {
                        this.showToast("Atenção", "Este produto não existe!", "warning");
                        return;
                    }

                    this.products = result[0];
                })
                .catch((error) => {
                    if (error.status == 500) {
                        this.showToast("Atenção", "A pesquisa está em branco", "warning");
                    }
                });
        }
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
