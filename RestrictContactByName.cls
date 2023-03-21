***** RestrictContactByName.cls ***** 

trigger RestrictContactByName on Contact (before insert, before update) {
	
	//check contacts prior to insert or update for invalid data
	
	For (Contact c : Trigger.New) {
        
		if(c.LastName == 'INVALIDNAME') {	//invalidname is invalid
            
			c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
		}

	}
}
    
    
    ***** TestRestrictContactByName *****
    
    @isTest
private class TestRestrictContactByName {
    
    @isTest static void TestRContactByName(){
    
       List<Contact> listCon = new List <Contact> ();
        
       Contact c1 = new Contact (FirstName='Gautam', LastName='Kumar', email='gautam3456@gmail.com');
       Contact c2 = new Contact (FirstName='Rohan', Lastname='INVALIDNAME', email='invalidname453@gmail.com');
       
       listCon.add(c1);
       listCon.add(c2);
        
       Test.startTest();
        
        try
        {
            insert listCon;
        }
        catch(Exception e)
        {
            System.debug('The Last Name "INVALIDNAME" is not allowed for DML');
        }
        Test.stopTest();
        
    }

}
