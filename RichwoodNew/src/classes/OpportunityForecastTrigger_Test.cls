@isTest
public class OpportunityForecastTrigger_Test {
	@isTest
    public static void CaseTwo(){
  		System.runAs(new User(Alias = 'standt', Email='standarduser@testorg.com', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = [SELECT Id FROM Profile WHERE Name='Standard User'].Id, TimeZoneSidKey='America/Los_Angeles', UserName='standadsjfjsdfjsrduser@testorg.com')) {
          Opportunity opp = new opportunity(Name='Test', stageName='Qualification', closeDate=date.newInstance(2016, 8, 1));
          insert opp;
          opp.closeDate=date.newInstance(2016, 10, 1);
          update opp;
          opp.StageName='PO Received';
          update opp;
          opp.StageName='Closed Lost';
          update opp;
      }
    }
}