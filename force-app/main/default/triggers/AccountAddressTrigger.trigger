trigger AccountAddressTrigger on Account (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            for (Account acc : Trigger.new) {
                if (acc.Match_Billing_Address__c) {
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        } 
        if (Trigger.isUpdate) {
             for (Account acc : Trigger.new) {
                if (acc.Match_Billing_Address__c) {
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
             }
        }
	}
}