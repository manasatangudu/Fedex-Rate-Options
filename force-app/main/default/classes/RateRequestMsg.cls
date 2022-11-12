public class RateRequestMsg {
    public AccountNumberMsg accountNumber;
    public RequestedShipmentMsg requestedShipment;
    
    public class AccountNumberMsg{
        public String value;
    } 
    public class RequestedShipmentMsg{
        public ShipperMsg shipper;
        public RecipientMsg recipient;
        public String pickupType;
        public List<String> rateRequestType;
        public List<RequestedPackageLineItemMsg> requestedPackageLineItems;

        public RequestedShipmentMsg(RecipientMsg recipientAdd, ShipperMsg shipperAdd) {
            this.recipient = recipientAdd;
            this.shipper = shipperAdd;
        }
    }
    public class ShipperMsg{
        public AddressMsg address;
    }
    public class AddressMsg{
        public String postalCode;
        public String countryCode;
    }
    public class RecipientMsg{
        public AddressMsg address;
    }
    public class RequestedPackageLineItemMsg{
        public WeightMsg weight;
    }
    public class WeightMsg{
        public String units;
        public decimal value;
    }

    public RateRequestMsg(String accNumber, RequestedShipmentMsg requestedShipment) {
        AccountNumberMsg accNumberMsg = new AccountNumberMsg();
        accNumberMsg.value = accNumber;
        this.accountNumber = accNumberMsg;
        this.requestedShipment = requestedShipment;
       
    }
}