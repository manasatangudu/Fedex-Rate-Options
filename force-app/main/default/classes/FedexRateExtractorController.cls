public with sharing class FedexRateExtractorController {
  @AuraEnabled
  public static string getRateOptions(
    String recipient,
    String shipper,
    Decimal weightValue
  ) {
    List<RateResponseMsg.RateReplyDetailsMsg> rateOptions;
    try {
      RateRequestMsg.AddressMsg recipientAddress = (RateRequestMsg.AddressMsg) JSON.deserialize(
        recipient,
        RateRequestMsg.AddressMsg.class
      );
      RateRequestMsg.AddressMsg shipperAddress = (RateRequestMsg.AddressMsg) JSON.deserialize(
        shipper,
        RateRequestMsg.AddressMsg.class
      );
      System.debug('recipientAddress ' + recipientAddress);
      System.debug('shipperAddress ' + shipperAddress);
      RateRequestMsg.ShipperMsg requestShipMsg = new RateRequestMsg.ShipperMsg();
      requestShipMsg.address = shipperAddress;
      RateRequestMsg.RecipientMsg requestRecipientMsg = new RateRequestMsg.RecipientMsg();
      requestRecipientMsg.address = recipientAddress;
      RateRequestMsg.WeightMsg rateWeightMsg = new RateRequestMsg.WeightMsg();
      rateWeightMsg.units = 'LB';
      rateWeightMsg.value = weightValue;
      RateResponseMsg rateResMsg = RateRequestService.getRateOptions(
        requestRecipientMsg,
        requestShipMsg,
        rateWeightMsg
      );
      if (rateResMsg.StatusCode != 200) {
        String errorMsg = '';
        for (Integer i = 0; i < rateResMsg.errors.size(); i++) {
          system.debug(rateResMsg.errors[i].message);
          errorMsg = errorMsg + rateResMsg.errors[i].message;
        }
        throw new RateOptionsException(rateResMsg.StatusCode + ':' + errorMsg);
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage());
    }
    return JSON.serialize(rateOptions);
  }
  public class RateOptionsException extends Exception {
  }
}
