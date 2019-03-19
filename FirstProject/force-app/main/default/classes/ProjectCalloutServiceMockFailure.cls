@isTest
global class ProjectCalloutServiceMockFailure implements HttpCalloutMock {
   //Implement http mock callout failure here
    global HTTPResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('{"example":"bad request"}');
        res.setStatusCode(400);
        return res;
        
    } 
}