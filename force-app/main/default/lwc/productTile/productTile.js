import { LightningElement, api } from 'lwc';

import { NavigationMixin } from 'lightning/navigation';
import PRODUCT_OBJECT from '@salesforce/schema/Product2';

/**
 * A presentation component to display a Product__c sObject. The provided
 * Product__c data must contain all fields used by this component.
 */
export default class ProductTile extends NavigationMixin(LightningElement) {
    /** Whether the tile is draggable. */
    @api draggable;

    _product;
    
    @api
    get product() {
        return this._product;
    }
    set product(value) {
        this._product = value;
        this.pictureUrl = value.Picture_URL__c;
        this.name = value.Name;
        this.msrp = value.MSRP__c;
    }

    /** Product__c field values to display. */
    pictureUrl;
    name;
    msrp;

    handleClick() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this._product.Id,
                objectApiName: PRODUCT_OBJECT.objectApiName,
                actionName: 'view'
            }
        });

    }

    handleDragStart(event) {
        event.dataTransfer.setData('product', JSON.stringify(this.product));
    }
}