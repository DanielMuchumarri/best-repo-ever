@isTest
private class ProjectRESTServiceTest {
  
    //Implement mock callout tests here
    @testSetup static void testData(){        
        Account acc = new Account();
        acc.name = 'tst Account';
        insert acc;
	        
        Opportunity opty = new Opportunity();
        opty.accountId = acc.Id;
        opty.Name = 'test opty';
        opty.StageName = 'Closed Won';
        //opty.ProjectRef__c = '213123343';
        Date dt = Date.newInstance(2018,12,14);
        opty.CloseDate = dt;
        opty.Amount = 1;
        insert Opty;       
        
        //Custom setting creation
        ServiceTokens__c servToken = new ServiceTokens__c();
        servToken.Name = 'ProjectServiceToken';
        servToken.Token__c = 'shgglskgblsbglbdsflgbldmfbgldb';
        insert servToken;        
    }     
    
    //Implement Apex REST service tests here
    @isTest private static void testProjectData(){        
        List<Opportunity> listOpty = [select Id from Opportunity];        
        Test.startTest();
        Date startDate = Date.newInstance(2018,12,12);
        Date endDate = Date.newInstance(2018,12,14);
        Double dt = 1.1;
        ProjectRESTService.postProjectData('213123343','Test Project',listOpty[0].Id,startDate,endDate,dt,'Running');
        Test.stopTest();
    }
    
    //Implement Apex REST service tests here
    @isTest private static void testProjectData1(){        
        List<Opportunity> listOpty = [select Id from Opportunity];        
        Test.startTest();
        Date startDate = Date.newInstance(2018,12,12);
        Date endDate = Date.newInstance(2018,12,14);
        Double dt = 1.1;
        ProjectRESTService.postProjectData('213123343','Test Project',listOpty[0].Id,startDate,endDate,dt,'Running1');
        Test.stopTest();
    }
    
    
}