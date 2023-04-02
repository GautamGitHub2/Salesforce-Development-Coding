public class CurrencyConverterClass 
{
    public static Decimal convertCurrencyToINR(Decimal USD)
    {
        Decimal inr = 0.0;
        
        HTTP h = new HTTP(); // here 'h' is the object of the HTTP default method without it we cannot call an API
        
        HTTPRequest req = new HTTPRequest(); // so before making http req i have to make object of HTTPRequest class
        
        req.setEndpoint('https://free.currconv.com/api/v7/convert?q=USD_INR&compact=ultra&apiKey=pasteTheAPI-KEYfromMail'); // this is endpoint URL from where we have to get the conversion rate from USD to INR, needs to be set
        req.setMethod('GET'); // to call the GET method from this API
        
        HTTPResponse res = h.send(req); // here 'h' object of HTTP has been used to get the response 
        
        Map<String,Object> jsonBody = (Map<String,Object>) Json.deserializeUntyped(res.getBody());
        
        Map<String,Object> mMap = (Map<String,Object>) jsonBody.get('results');
        
        Map<String,Object> mMap2 = (Map<String,Object>) mMap.get('USD_INR');
        
        System.debug(jsonBody); //{error=API Key is required., status=400}; so as of now in this case i am not able to mke this API call 
        System.debug(mMap); // it is returning null and 0.0
        System.debug(mMap2);
        
        Decimal conversionRate = (Decimal) mMap2.get('val'); // keep an eye on case sensitive part like 'results' and 'val' otherwise it will give error while executing
                                    
        inr = usd * conversionRate;
        
        return inr;    
        
  }

}                                  
/*
Go to the documentation part for getting the sample code...
//https://www.currencyconverterapi.com/docs

now open the link in new tab "PHP Sample Code for Currency Conversion"

and copy the url:https://api.currconv.com/api/v7/convert?q={$query}&compact=ultra&apiKey={$apikey} 

where we have to make the req.

the final endpoint URL for making req. is:

For using the Free servers...

'https://free.currconv.com/api/v7/convert?q=USD_INR&compact=ultra&apiKey='

*/

/*
Video-115

when user wants to use this API of Accounting Software this AS has provided an URL which is unique to the API that user want to call, so it's like user hasn't created that API this endpoint URL (this is basically provided by the application the developer who has created that API)

so for all 3 Map<String,Object> the details are...

in JSON Body there are MAPs because itself it is in MAP format that contains KEY-VALUE pair 

inside the jsonBody there is the key that is called results, and inside results the values are from another MAP so need to get that MAP (here in mMap) 

and inside the mMap2 there is 'USD_INR' value that i have to get so the USD_INR is basically the key and conversionRate between the USD and INR is the value, and how will we get that, we will get it through mMap.get('USD_INR') [here mMap2] mMap2.get('val');

once i get the conversionRate just simply multiplied with USD and the results would be in INR.

and just return the INR.

now execute the above program, 

Decimal d = CurrencyConverterClass.convertCurrencyToINR(25);
System.debug(d);

Line: 14, Column: 1
System.CalloutException: Unauthorized endpoint, please check Setup->Security->Remote site settings. endpoint = https://free.currconv.com/api/v7/convert?q=USD_INR

above line of code for execution is giving error...

Explanation:

if i allow all the endpoints and if you allow the dev to write the code and send all the info of Salesforce org to some other application to send some other endpoint URL then it could be the reason of a problem
so any dev who writes the code and send all the info to some other application/server/endpoint URL that contains customer info, username & password some sensitive info. etc then it becomes the problem.

so as an admin of dev. org. it is a responsibility that to take care of remote site settings to which endpoint URL to make a req. inside the APEX Class/code 

for this go to setup --> Remote Site Settings --> New Remote Site with the Remote URL: https://free.currconv.com/api/v7/convert?q=USD_INR

click on Save.

now execute the code

again below error is coming:
Line: 20, Column: 1
System.NullPointerException: Attempt to de-reference a null object

the reason of this is that response i have sending it has been changed 

so making some changes in the code above mentioned at line number 20.

the problem is with the API Key, because remember that earlier in the 110-113 sessions for POST and GET methods API we were generating Access Tokens again and again inside the authentication headers

its the same thing happening here but this is the free API and the free API doesnot require access token if i would have purchase it then i would have needed it.

and pass but currently i don't have it.

for getting the free API Key, just click on [ the page of (https://www.currencyconverterapi.com/docs) ] Free Version and click on "Get Your Free API Key or Renew Your Expired API Key"

here i requested for the free API Key by entering my details (name,mobile number and email address) and as per the new rule of this website for free api key will be delivered to me after 3 days.

and after getting this free api key i have to modify my endpoint url:

https://free.currconv.com/api/v7/convert?q=USD_INR&compact=ultra&apiKey=API_KEY --> that's has been received in mail

just execute once again but same error is coming so better to use the endpoint URL that i have received in the mail (change from USD_PHP to USD_INR) and save and try to execute once again --> it should work with the latest USD value in INR  

and if i remove this part from the endpoint URL 'compact=ultra&' then save & execute, the results would be like:

{
query={count=1}, 
results={USD_INR={fr=USD, id=USD_INR, to=INR, val=82.18}}
}

so this is the complete JSON format.

1. Query --> getting Map inside 'jsonBody' complete JSON format
2. Count --> 
3. Results --> mMap
4. USD_IN --> mMap2 and from this we are getting value 'val=82.18' 

so this API callout and APEX callouts are the different-2 things for the diff.-2 API

*/        
                        
      
