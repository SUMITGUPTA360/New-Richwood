/*
*Created By: Snapp
*Created Date: 1-Nov-2016
*Purpose: Controller for Tracking Page
*/
public with sharing class TrackingController {
    
    public String linkId ;
    public Email_Link__c el ;
    public String error {get;set;}
    public TrackingController(){
    //Contructor	
    linkId=ApexPages.currentPage().getParameters().get('linkid');
    }
    
    public PageReference track(){
    	//Get the link Id
    	linkId=ApexPages.currentPage().getParameters().get('linkid');
    	
    	if(linkId!=null)
    	{
	    	if([Select count() from Email_Link__c where Link_Identifier__c=:linkId]>0){	
	    		//Get the Email Link object associated with the Id
	    		Email_Link__c el = [Select Id,Name,Destination_URL__c,Link_Identifier__c,
	    							Link_to_Use__c,Campaign__c
	    						 	from Email_Link__c where Link_Identifier__c=:linkId];
	    						 	
	    		
    			
    			//Create a click through record with details
    			Click_Through__c ct = new Click_Through__c (Email_Link__c=el.Id);
    			ct.IP_Address__c=getUserIPAddress();
    			ct.User_Agent__c=ApexPages.currentPage().getHeaders().get('User-Agent');
    			insert ct;
    			
    			//Redirect to destination URL
    			PageReference pg = new PageReference('http://'+el.Destination_URL__c);
    			pg.setRedirect(true);
    			return pg;
    		}
    		else
    			{//Link Not found
    				error='Error: Invalid link. Please correct the URL.'; return null; }				 	
    		
    	}
    	else
    			{//Link Id is missing
    				error='Error : Missing link id parameter. Please correct the URL'; return null; }			
    }
    
    public static String getUserIPAddress() {
		 string ReturnValue = '';  
		   
		 // True-Client-IP has the value when the request is coming via the caching integration.
        ReturnValue = ApexPages.currentPage().getHeaders().get('True-Client-IP');
 
          // X-Salesforce-SIP has the value when no caching integration or via secure URL.
        if (ReturnValue == '' || ReturnValue == null) {
         ReturnValue = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        } // get IP address when no caching (sandbox, dev, secure urls)
 
         if (ReturnValue == '' || ReturnValue == null) {
         ReturnValue = ApexPages.currentPage().getHeaders().get('X-Forwarded-For');
        } // get IP address from standard header if proxy in use
		 
		 return ReturnValue;
		  
	} // GetUserIPAddress
}