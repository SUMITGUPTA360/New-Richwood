/*
*Created By: Snapp
*Created Date: 1-Nov-2016
*Purpose: Test class for TrackingController 
*/
@isTest
private class TrackingControllerTest {

    static testMethod void myUnitTest() {
        
        Account acc= new Account(Name='Test');
        insert acc;
        
        Campaign pec = new Campaign(Name='test');
        insert pec;
        
        Email_Link__c el = new Email_Link__c(Campaign__c=pec.Id,
        									Destination_URL__c='www.google.com');
        insert el;
        
        el= [Select Id,Name,Link_Identifier__c from Email_Link__c where Id= :el.Id ];
        Test.startTest();
        
        PageReference pg = Page.TrackingPage;
        Test.setCurrentPageReference(pg);
        
        TrackingController ctrl = new TrackingController();
        ctrl.track();
        
        ApexPages.currentPage().getParameters().put('linkid',el.Link_Identifier__c);
        ctrl.track();
        
         ApexPages.currentPage().getParameters().put('linkid','w234');
        ctrl.track();
        
        
        Test.stopTest();									
        
    }
}