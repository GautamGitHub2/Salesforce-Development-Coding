public class AnimalLocator {
    public static HttpResponse getAnimalNameById(Integer num){
    
        Http http = new Http();
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+num);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode()==200){
        Map<String,Object> results =(Map<String,Object>) Json.deserializeUntyped(response.getBody());
        
        System.debug('Received the selected animal:' +results);
        System.debug('Response>>>>>'+response);    
         
        }
         return response;
    }
}

@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request)
    {
        //Create a fake response
        HTTPResponse response = new HTTPResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":2,"name":"bear","eats":"berries, campers, adam seligman","says":"yum yum"}}');
        response.setStatusCode(200);
        
        return response;
    }
}            

@isTest
private class AnimalLocatorTest {
    private static testmethod void testAnimalLocatorTest(){
        
        AnimalLocatorMock mock = new AnimalLocatorMock();
        
        // Associate the callout with a mock response
        
        Test.setMock(HttpCalloutMock.class, mock);
        
        //Call AnimalLocator method to test
        
        HttpResponse result = AnimalLocator.getAnimalNameById(2);
        
        //Verify mock response is not null
        
        System.assertNotEquals(null,result, 'The callout returned a null response');
        
        //Verify Status Code
        
        System.assertEquals('application/json',result.getHeader('Content-Type'),'The content type value is not expected');
        
        //Verify the array contains 3 times
        Map<String,Object> results =(Map<String,Object>) JSON.deserializeUntyped(result.getBody());
        
        System.assertEquals(1,results.size(),'The array should only contain 3 items');
        
    }
}
