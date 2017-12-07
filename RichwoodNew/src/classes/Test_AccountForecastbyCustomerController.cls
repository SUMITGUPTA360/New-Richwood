@isTest
public class Test_AccountForecastbyCustomerController {
    static testMethod void test() {
         User u1 = [SELECT Id FROM User WHERE name='Judd Roseberry'];
            
         Account a = new Account(name = 'test',ownerId = u1.Id,Include_in_Forecast__c = true);
         insert a;
        
        insert new Product_Category__c(Description__c = 'Uploaded',Type__c = '4-Parts');
        insert new Product_Category__c(Description__c = 'Uploaded');
        
        ApexPages.CurrentPage().getParameters().put('Id',a.id);
        ApexPages.CurrentPage().getParameters().put('year','2017');
        AccountForecastbyCustomerController obj = new AccountForecastbyCustomerController();
        Obj.InitializingData();
        
        Obj.projectType='None';
        Obj.projectIdx=0;
        Obj.updateForecast();
        
        Obj.previous();
        Obj.next();
        Obj.SubmitForecast();
        
        //Creating Capital Project
        Obj.createNewCapitalProject();
        Obj.capitalprojectidx=0;
        Obj.capitalProject_List[0].capitalProject.Name='Test';
        Obj.updateCapitalProject();
        
        // Creating Capital Project Forecast Object
        Obj.createNewCapitalForecast();
        
        // Updating Capital Project        
        Obj.capitalProject_List[0].capitalProject.Status__c='Complete';
        Obj.updateCapitalProject();
        
        Obj.save();
    }
}