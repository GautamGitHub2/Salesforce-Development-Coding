****** RandomContactFactory ****

public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numCon, String FName){
        
        List<Contact> listCon = new List<Contact>();
        
        for(Integer i=0; i<numCon; i++)
        {
            Contact con=new Contact(FirstName=FName + ' ' +i, LastName='Contact ' +i);
            listCon.add(con);
            System.debug(con);
        }
        //insert listCon;
        System.debug(listCon.size());
        return listCon;
    }
}
    
##### Execute As #####
RandomContactFactory.generateRandomContacts(5,'FName');

      #### Output #####
      
      18:13:45:006 USER_DEBUG [10]|DEBUG|Contact:{FirstName=FName 0, LastName=Contact 0}
      18:13:45:006 USER_DEBUG [10]|DEBUG|Contact:{FirstName=FName 1, LastName=Contact 1}
      18:13:45:006 USER_DEBUG [10]|DEBUG|Contact:{FirstName=FName 2, LastName=Contact 2}
      18:13:45:006 USER_DEBUG [10]|DEBUG|Contact:{FirstName=FName 3, LastName=Contact 3}
      18:13:45:006 USER_DEBUG [10]|DEBUG|Contact:{FirstName=FName 4, LastName=Contact 4}
      18:13:45:006 USER_DEBUG [10]|DEBUG|5
    
      
    
