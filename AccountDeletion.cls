***** AccountDeletion *****

trigger AccountDeletion on Account (before delete) {
    
    // Prevent the deletion of accounts if they have related opportunities
    
    for (Account a: [Select Id From Account 
                     Where Id IN (Select AccountId From Opportunity) 
                     And Id IN: Trigger.old]){
        Trigger.oldMap.get(a.Id).addError('Cannot delete account with related opportunities...');
    }

}
          
***** TestAccountDeletion *****
          
@isTest
private class TestAccountDeletion {
    
    @isTest static void TestDeleteAccountWithOneOpportunity(){
        
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        
        Account acc = new Account(Name='Test AccountDelete');
        
        insert acc;
        
        Opportunity opp = new Opportunity(Name=acc.Name + 'Opportunity', StageName='Prospecting',CloseDate=System.today().addMonths(1),AccountId=acc.Id);
        
        insert opp;
        
        //Perform test
        
        Test.startTest();
        
        Database.DeleteResult result = Database.delete(acc, false);
        
        Test.stopTest();
        
        //Verify, In this case the deletion should have been stopped by the trigger, so verify that we got back an error...
        
        System.Assert(!result.isSuccess());
        System.Assert(result.getErrors().size()>0);
        System.AssertEquals('Cannot delete account with related opportunities...', result.getErrors()[0].getMessage());
    }

}          
          
