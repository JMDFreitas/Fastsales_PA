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

            findProducts({ clause: "Name", filter: this.searchKey, orderBy: "CreatedDate" })
                .then((result) => {
                    if (result.length === 0) {
                        this.showToast("Atenção", "Esta produto não existe!", "warning");
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
