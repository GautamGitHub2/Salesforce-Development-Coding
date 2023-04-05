global class LeadProcessor implements Database.Batchable<sObject>{
    global Database.QueryLocator start (Database.BatchableContext bc)
    {
        return Database.getQueryLocator([Select Name from Lead]);
        
    }
    global void execute(Database.BatchableContext bc, List<Lead> lList)
    {
        for(Lead l:lList)
        {
            l.LeadSource='Dreamforce';
        }
        update lList;
    }
    global void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        String[] toAddress = new String[]{'kr1102@gmail.com','kumargautam1102@gmail.com'};
            
        email.setToAddresses(toAddress);
        email.setSubject('Job Completed');
        email.setPlainTextBody('Hi Gautam Kumar! Congrats! Batch Job has been completed...!!');
        
        messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    
        Id job=bc.getJobId();
        System.debug(job);
    
    }

}
          
//

@IsTest
private class LeadProcessorTest {
    private static testmethod void testLeadProcessorTest()
    {
        List<Lead> leadList=new List<Lead>();
        
        Lead l1=new Lead();
        l1.LastName='Gautam';
        l1.Company='Accenture';
        l1.Status='Closed-Converetd';
        l1.LeadSource='Dreamforce';
        
        leadList.add(l1);
        
        insert leadList;
        
        /*
        for(Integer i=1;1<=2;i++)
        {
           leadList.add(
           new Lead(
           Salutation='Mr.',    
           LastName='Test '+i,
           Rating='Warm',
           Company='Accenture')
           );
        }
        insert leadList;
        */
        
        Test.startTest();
        LeadProcessor lp=new LeadProcessor();
        Id jobid=Database.executeBatch(lp);
        Test.stopTest();
        
        //  Lead lead1=[Select LeadSource from Lead where Company='Accenture' Limit 1];
        //System.assertEquals('Dreamforce' , 'Dreamforce' );
        
    }

}
