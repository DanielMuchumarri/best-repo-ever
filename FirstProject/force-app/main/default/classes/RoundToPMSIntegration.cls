public class RoundToPMSIntegration {
    @InvocableMethod(label='Round PMS Integration' description='Round PMS Integration Description')
    public static void sendOptytoPMSProject(List<Opportunity> optyList){
		RoundToPMSIntegration.invokeFuture(optyList[0].Id);
    }
    
    public class optyWrapper{        
        string opportunityId;
        string opportunityName;
        string accountName;
        string closeDate;
        string amount;        
    }
    @future(callout=true)
    public static void invokeFuture(Id optyId){
        Opportunity opty = [select Id,Name,Account.Name,CloseDate,Amount from opportunity where id = :optyId];
		//Opportunity Opty = new Opportunity();        
        //if(optyList != null)
        //Opty = optyList[0];        
        System.debug('Opportunity Record' + opty);
        System.debug('Opportunity account Record' + opty.Account.Name);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:ProjectService');
        RoundToPMSIntegration.optyWrapper optyJson = new RoundToPMSIntegration.optyWrapper();
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
    }
    
    
    
}