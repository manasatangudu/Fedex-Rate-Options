import { LightningElement } from "lwc";
import getRateOptions from "@salesforce/apex/FedexRateExtractorController.getRateOptions";

export default class FedexRateExtractor extends LightningElement {
  recipient = {};
  shipper = {};
  weightValue = 0.0;
  shippingOptions = [];
  uiOptions = [];

  getRates() {
    this.shipper = this.template.querySelector(
      "c-address-input[data-my-id=shipper]"
    ).address;
    this.recipient = this.template.querySelector(
      "c-address-input[data-my-id=recipient]"
    ).address;
    getRateOptions({
      recipient: JSON.stringify(this.recipient),
      shipper: JSON.stringify(this.shipper),
      weightValue: this.weightValue
    })
      .then((result) => {
        if (result) {
          this.shippingOptions = JSON.parse(result);
          this.uiOptions = this.shippingOptions.map((option) => ({
            serviceName: option.serviceName,
            totalNetCharge: option.ratedShipmentDetails[0].totalNetCharge,
            totalBaseCharge: option.ratedShipmentDetails[0].totalBaseCharge
          }));
        }
      })
      .catch((error) => {
        console.log("error: ", error);
      });
  }
  handleWeight(event) {
    this.weightValue = event.detail.value;
    console.log("weight" + this.weightValue);
  }
}
