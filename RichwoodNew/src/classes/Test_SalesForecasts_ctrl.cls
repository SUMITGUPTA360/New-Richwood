@isTest
public class Test_SalesForecasts_ctrl{
    static testMethod void test() {
        User u1 = [SELECT Id FROM User WHERE name='Judd Roseberry'];
        Account a = new Account();
        a.name = 'test';
        a.ownerId = u1.Id;
        a.Include_in_Forecast__c = true;
        insert a;
        
        Account_Yearly_Forecast__c ayfc = new  Account_Yearly_Forecast__c();
        ayfc.Account__c = a.Id;
        ayfc.Forecast_Period_Start__c = system.today().addYears(1);
        ayfc.Forecast_Status__c = 'Submitted';
        ayfc.name = 'test';
        insert  ayfc;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = a.Id;
        opp.Amount = 3000;
        opp.Name = 'testopp1';
        opp.CloseDate  = system.today().addYears(1);
        opp.StageName = 'Qualification';
        opp.Quote_Type__c='Labor Only';
        insert opp;
        
        Opportunity oppclose = new Opportunity();
        oppclose.AccountId = a.Id;
        oppclose.Amount = 4000;
        oppclose.Name = 'testopp1';
        oppclose.CloseDate  = system.today();
        oppclose.StageName = 'Closed Lost';
        oppclose.Quote_Type__c='Labor Only';
        insert oppclose;
        
         Product_Category__c pcc = new Product_Category__c();
         pcc.Description__c = 'Uploaded';
         pcc.Type__c = '4-Parts';
         insert pcc;
        
        Forecast_Product_Category__c fpc = new Forecast_Product_Category__c();
        fpc.Units__c = 1234;
        fpc.Projected_Amount__c = 226;
        fpc.Account_Yearly_Forecast__c = ayfc.Id ;
        fpc.Product_Category__c = pcc.Id ;
        insert fpc;
        
        SalesForecasts_ctrl cntrl = new SalesForecasts_ctrl();
        //cntrl.getGetOption();
        cntrl.setFilter();
        cntrl.defaultDateTest='01/01/2017';
        cntrl.dateChange();
        cntrl.customDateChange();
        cntrl.updateSortDirection();
        cntrl.sortDirection='asc';
        cntrl.currentField='accName';
        cntrl.updateSortDirection();
        cntrl.currentField='Forecast_Status';
        cntrl.updateSortDirection();
        cntrl.currentField='cwSum_2year';
        cntrl.updateSortDirection();
        cntrl.currentField='cwSum_1year';
        cntrl.updateSortDirection();
        cntrl.currentField='pAmountSum';
        cntrl.updateSortDirection();
        cntrl.currentField='cwSum';
        cntrl.updateSortDirection();
        cntrl.currentField='openSum';
        cntrl.updateSortDirection();
        
        
       
}
        
}