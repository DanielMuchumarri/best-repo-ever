@isTest
private class ProjectCalloutServiceTest {
  //Implement mock callout tests here
    @testSetup static void testData(){
        
        Account acc = new Account();
        acc.name = 'tst Account';
        insert acc;
        
        Opportunity opty = new Opportunity();
        opty.accountId = acc.Id;
        opty.Name = 'test opty';
        opty.StageName = 'Closed Won';
        Date dt = Date.newInstance(2018,12,14);
        opty.CloseDate = dt;
        opty.Amount = 1;
        insert Opty;
        
        Opportunity opty1 = new Opportunity();
        opty1.accountId = acc.Id;
        opty1.Name = 'test opty';
        opty1.StageName = 'Closed Won';
        Date dt1 = Date.newInstance(2018,12,14);
        opty1.CloseDate = dt1;
        opty1.Amount = 1;
        insert Opty1;
        
        //Custom setting creation
        ServiceTokens__c servToken = new ServiceTokens__c();
        servToken.Name = 'ProjectServiceToken';
        servToken.Token__c = 'shgglskgblsbglbdsflgbldmfbgldb';
        insert servToken;
        
    } 
        
  @isTest
    private static void testCalloutSuccess(){
              
        List<Opportunity> listOpty = [SELECT Id, name,StageName, Account.Name, Amount, CloseDate from Opportunity];        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new ProjectCalloutServiceMock());  
        ProjectCalloutService.postOpportunityToPMS(new List<id>{listOpty[0].id});
        ProjectCalloutService.postToPMS(listOpty[0].id);
        Test.StopTest();
        List<Opportunity> listOptyNew = [SELECT Id, StageName,name, Account.Name, Amount, CloseDate from Opportunity];        
        System.assertEquals('Submitted Project', listOptyNew.get(0).StageName);
        
    }
    
    @isTest private static void testCalloutFailure(){
        List<Opportunity> listOpty = [SELECT Id, name,StageName, Account.Name, Amount, CloseDate from Opportunity];
        Test.startTest();
        Test.setMock(HttpCalloutMock.class,new ProjectCalloutServiceMockFailure());  
        ProjectCalloutService.postOpportunityToPMS(new List<id>{listOpty[1].id});
        ProjectCalloutService.postToPMS(listOpty[1].id);
        Test.StopTest();
        List<Opportunity> listOptyNew1 = [SELECT Id, StageName,name, Account.Name, Amount, CloseDate from Opportunity];        
        System.assertEquals('Resubmit Project', listOptyNew1.get(1).StageName);
        
    }
  
}