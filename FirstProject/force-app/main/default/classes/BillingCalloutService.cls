public class BillingCalloutService {
    //Implement business and callout logic methods here
    @future(callout=true)
    public static void callBillingService(String ProjectId,String projectRef, Decimal BillingAmount){
        BillingServiceProxy.project  tmpProject = new BillingServiceProxy.project();
        tmpProject.username = ServiceCredentials__c.getInstance('BillingServiceCredential').Username__c;
        tmpProject.password = ServiceCredentials__c.getInstance('BillingServiceCredential').Password__c;
        tmpProject.projectid = projectRef;
        tmpProject.billAmount = BillingAmount;
        BillingServiceProxy.InvoicesPortSoap11 billingSoap = new BillingServiceProxy.InvoicesPortSoap11();
        String response = billingSoap.billProject(tmpProject);
        if(response != null && response.equalsIgnoreCase('OK')){         	
            List<Project__c> listProjects = [SELECT Id,Status__c from Project__c where Id = :ProjectId];            
            listProjects.get(0).Status__c = 'Billed';  
            update listProjects;
        }
    }
}