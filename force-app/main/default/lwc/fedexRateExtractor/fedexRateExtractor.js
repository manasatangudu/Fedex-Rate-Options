import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getRateOptions from "@salesforce/apex/FedexRateExtractorController.getRateOptions";
import { reduceErrors } from "c/utils";

export default class FedexRateExtractor extends LightningElement {
  recipient = {};
  shipper = {};
  weightValue = 0.0;
  shippingOptions = [];
  uiOptions = [];
  showSpinner = false;

  getRates() {
    this.showSpinner = true;
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
          this.showSpinner = false;
          this.shippingOptions = JSON.parse(result);
          this.uiOptions = this.shippingOptions.map((option) => ({
            serviceName: option.serviceName,
            totalNetCharge: option.ratedShipmentDetails[0].totalNetCharge,
            totalBaseCharge: option.ratedShipmentDetails[0].totalBaseCharge
          }));
        }
      })
      .catch((error) => {
        this.showSpinner = false;
        console.log("error: ", reduceErrors(error).toString());
        console.log("error: ", error);
        const event = new ShowToastEvent({
          title: "Shipping Options Error",
          variant: "error",
          message: reduceErrors(error).toString()
        });
        this.dispatchEvent(event);
      });
  }
  handleWeight(event) {
    this.weightValue = event.detail.value;
    console.log("weight" + this.weightValue);
  }
}
