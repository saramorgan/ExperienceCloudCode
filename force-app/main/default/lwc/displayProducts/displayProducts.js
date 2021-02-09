// This component is very similar to the producTilelist LWC in the E-Bikes Sample app
// https://github.com/trailheadapps/ebikes-lwc

import { LightningElement, api, wire } from 'lwc';

// Ligthning Message Service and message channels
//import { publish, MessageContext } from 'lightning/messageService';
//import PRODUCT_SELECTED_MESSAGE from '@salesforce/messageChannel/ProductSelected__c';

// getProducts() method in ProductController Apex class
import getProducts from '@salesforce/apex/ProductController.getProducts';

export default class DisplayProducts extends LightningElement {
    // Corresponds to the targetConfig properties in the meta file
    @api searchBarIsVisible = false;
    @api tilesAreDraggable = false;

    pageNumber = 1;       // Current page in the product list
    totalItemCount = 0;   // The total number of items matching the selection.
    pageSize;             // The number of items on a page.
    filters = {};         // JSON.stringified version of filters to pass to apex  
   
    // Load context for Ligthning Messaging Service 
    //@wire(MessageContext) messageContext;

    // Load the list of available products.
    @wire(getProducts, { filters: '$filters', pageNumber: '$pageNumber' })
    products;

    //Publish ProductSelected message
    // handleProductSelected(event) {  
    //     publish(this.messageContext, PRODUCT_SELECTED_MESSAGE, {
    //         productId: event.detail
    //     });
    // }

    handleProductSelected(productId) {
        this.recordId = productId;
    }

    handleSearchKeyChange(event) {
        this.filters = { searchKey: event.target.value.toLowerCase() };
        this.pageNumber = 1;
    }

    handlePreviousPage() {
        this.pageNumber = this.pageNumber - 1;
    }

    handleNextPage() {
        this.pageNumber = this.pageNumber + 1;
    }

}