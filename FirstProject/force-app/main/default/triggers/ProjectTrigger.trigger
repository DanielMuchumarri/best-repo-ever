trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    
    for(Project__c tmpProj : Trigger.new){
        if(tmpProj.Status__c == 'Billable'){
            BillingCalloutService.callBillingService(tmpProj.Id,tmpProj.ProjectRef__c,tmpProj.Billable_Amount__c);
        }
    }
}