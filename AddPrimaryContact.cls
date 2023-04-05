public class AddPrimaryContact implements Queueable{
    private Contact c;
    private String state;
    
    public AddPrimaryContact(Contact c, String state)
    {
        this.c=c;
        this.state=state;
    }
 
    public void execute(QueueableContext context)
    {
      List<Account> listAccount = [Select Id,Name,(Select Id, FirstName, LastName from Contacts) from Account where BillingState=:state LIMIT 200];
      
      List<Contact> listContact = new List<Contact>();
      
      for(Account acc: listAccount)
      {
          Contact con=c.clone(false,false,false,false);
          con.AccountId=acc.Id;
          listContact.add(con);
      }
        if(listContact.size()>0)
        {
            insert listContact;
        }
    }       
    }
        //
        
        @isTest
public class AddPrimaryContactTest {
    
    public static testmethod void testAddPrimaryContactTest(){
        
        // testSetup
        List<Account> accList = new List<Account>();
        
        for(Integer i=0;i<50;i++)
        {
            accList.add(new Account(Name='TestNewAccount' +i, BillingState='NY'));
        }
        
        for(Integer i=50;i<100;i++)
        {
            accList.add(new Account(Name='TestNewAccount' +i,BillingState='CA'));
        }
        
        insert accList;
        
        //testSetUp
        String strState='CA';
        
        Contact con = new Contact(LastName='TestContact');
        AddPrimaryContact addPriCon = new AddPrimaryContact(con, strState); 
        
        
        //testExecution
        Test.startTest();
        System.enqueueJob(addPriCon);
        Test.stopTest();
        
        //TestResults
        System.assertEquals(50,[select count() from Contact where accountID IN(Select id from Account where BillingState=:strState)]);
    } 

}
