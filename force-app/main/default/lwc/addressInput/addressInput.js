import { LightningElement, api } from 'lwc';

export default class AddressInput extends LightningElement {
    @api address = {
        city: null,
        street: null,
        state: null,
        countryCode: 'US',
        countryLabel:'United States',
        postalCode: null
    };
    @api addressLabel;
    _country = 'US';

    countryOptions = [{ label: 'United States', value: 'US' }];

    get getCountryOptions() {
        return this.countryOptions;
    }

    handleChange(event) {
        this.address.street = event.detail.street;
        this.address.city = event.detail.city;
        this.address.country = event.detail.country;
        this.address.postalCode = event.detail.postalCode;
        this.address.state = event.detail.province;
        console.log('Street => ' , event.target.street);
        console.log('City => ' , event.target.city);
        console.log('Province => ' , event.target.province);
        console.log('Country => ' , event.target.country);
        console.log('postal Code => ' , event.target.postalCode);
        console.log('detail country => ' , event.detail.country);
        this._country = event.detail.country;
    }
}