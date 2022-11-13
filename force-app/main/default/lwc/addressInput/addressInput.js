import { LightningElement, api } from "lwc";

export default class AddressInput extends LightningElement {
  @api address = {
    city: null,
    street: null,
    state: null,
    countryCode: "US",
    countryLabel: "United States",
    postalCode: null
  };
  @api addressLabel;

  countryOptions = [{ label: "United States", value: "US" }];

  get getCountryOptions() {
    return this.countryOptions;
  }

  handleChange(event) {
    this.address.street = event.detail.street;
    this.address.city = event.detail.city;
    this.address.country = event.detail.country;
    this.address.postalCode = event.detail.postalCode;
    this.address.state = event.detail.province;
  }
}
