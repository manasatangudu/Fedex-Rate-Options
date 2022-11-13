public with sharing class RateRequestService {
  public static List<RateResponseMsg.RateReplyDetailsMsg> getRateOptions(
    RateRequestMsg.RecipientMsg recipient,
    RateRequestMsg.ShipperMsg shipper,
    RateRequestMsg.WeightMsg weightMsg
  ) {
    String requestBody = JSON.serialize(
      buildRequestBody(recipient, shipper, weightMsg)
    );
    System.debug('requestBody::' + requestBody);
    HttpResponse rateOptionsResponse = APIClient.apiCall(
      'POST',
      '/rate/v1/rates/quotes',
      'l76d77953a0f324fa2910834e632fb79ed',
      requestBody
    );
    RateResponseMsg responseMsg = (RateResponseMsg) JSON.deserialize(
      rateOptionsResponse.getBody(),
      RateResponseMsg.class
    );
    system.debug('rate response ::' + responseMsg);
    return responseMsg.output.rateReplyDetails;
  }

  public static RateRequestMsg buildRequestBody(
    RateRequestMsg.RecipientMsg recipient,
    RateRequestMsg.ShipperMsg shipper,
    RateRequestMsg.WeightMsg weightMsg
  ) {
    RateRequestMsg.RequestedShipmentMsg reqShipmentMsg = new RateRequestMsg.RequestedShipmentMsg(
      recipient,
      shipper
    );
    reqShipmentMsg.PickupType = 'DROPOFF_AT_FEDEX_LOCATION';
    reqShipmentMsg.rateRequestType = new List<String>{ 'ACCOUNT' };
    RateRequestMsg.RequestedPackageLineItemMsg requestPackMsg = new RateRequestMsg.RequestedPackageLineItemMsg();
    requestPackMsg.weight = weightMsg;
    reqShipmentMsg.requestedPackageLineItems = new List<RateRequestMsg.RequestedPackageLineItemMsg>{
      requestPackMsg
    };
    RateRequestMsg rateReqMsg = new RateRequestMsg('740561073', reqShipmentMsg);

    return rateReqMsg;
  }
}
