public class RateResponseMsg {
  public String transactionId;
  public OutputMsg output;

  public class OutputMsg {
    public List<RateReplyDetailsMsg> rateReplyDetails;
  }

  public class RateReplyDetailsMsg {
    @AuraEnabled
    public String serviceType;
    @AuraEnabled
    public String serviceName;
    @AuraEnabled
    public String packagingType;
    @AuraEnabled
    public List<RatedShipmentDetail> ratedShipmentDetails;
  }

  public class RatedShipmentDetail {
    @AuraEnabled
    public String rateType;
    @AuraEnabled
    public String ratedWeightMethod;
    @AuraEnabled
    public shipmentRateDetailMsg shipmentRateDetail;
    @AuraEnabled
    public decimal totalNetCharge;
    @AuraEnabled
    public decimal totalBaseCharge;
    @AuraEnabled
    public decimal totalNetFedExCharge;
  }

  public class shipmentRateDetailMsg {
    @AuraEnabled
    public String rateZone;
    @AuraEnabled
    public decimal totalSurcharges;
    @AuraEnabled
    public decimal totalFreightDiscount;
  }
}
