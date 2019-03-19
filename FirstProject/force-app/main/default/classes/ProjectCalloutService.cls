public class ProjectCalloutService {
    //Complete the implementation for business and callout logic
	@InvocableMethod(label='Post Opportunity To PMS' description='Round PMS Integration Description')
    public static void postOpportunityToPMS(List<Id> optyList){
		System.enqueueJob(new QueueablePMSCall(optyList[0]));
    }
    public class optyWrapper{        
        string opportunityId;
        string opportunityName;
        string accountName;
        string closeDate;
        string amount;        
    }
    @future(callout=true)
    public static void postToPMS(Id optyId){
        Opportunity opty = [select Id,Name,StageName,Account.Name,CloseDate,Amount from opportunity where id = :optyId];
		//Opportunity Opty = new Opportunity();        
        //if(optyList != null)
        //Opty = optyList[0];        
        System.debug('Opportunity Record' + opty);
        System.debug('Opportunity account Record' + opty.Account.Name);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ProjectService');
        ProjectCalloutService.optyWrapper optyJson = new ProjectCalloutService.optyWrapper();
        optyJson.opportunityId = opty.Id;
        optyJson.opportunityName = opty.Name;
        optyJson.accountName = opty.Account.Name;
        Date optyCloseDate = opty.CloseDate;
        optyJson.closeDate = optyCloseDate.year() + '-' + optyCloseDate.month() + '-' + optyCloseDate.day();
        optyJson.amount = opty.Amount.format();
        System.debug('optyJSON !!!!!' + JSON.serialize(optyJson));
        req.setHeader('token',ServiceTokens__C.getValues('ProjectServiceToken').Token__c);
        req.setHeader('Content-Type', 'application/json;charset=UTF-8'); 
        req.setBody(JSON.serialize(optyJson));
        req.setMethod('POST');
        Http http = new Http();
        HTTPResponse res = http.send(req);  
        System.debug('Response from callout @@@@' + res);
        if(res.getStatusCode() == 201){
            opty.StageName = 'Submitted Project';            
        }else{
           	opty.StageName = 'Resubmit Project';  
        }        
        update opty;
    }
    class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{        
        private String serviceToken;
        private String jsonInput;
        private String Id;        
        public QueueablePMSCall(Id oppoId){
            this.serviceToken = serviceToken;
            this.jsonInput = jsonInput;
            this.Id = oppoId;
        }        
        public void execute(QueueableContext context){
            System.debug('Opportunity ID value !!!!!' + Id);
            ProjectCalloutService.postToPMS(Id);
        }        
    }
}