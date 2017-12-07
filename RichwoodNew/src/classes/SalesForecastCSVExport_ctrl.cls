public class SalesForecastCSVExport_ctrl {
	public List<AggregateResult> AggregateResult_list {get;set;}
    public integer year{get;set;}
    public SalesForecastCSVExport_ctrl(){
        AggregateResult_list = new list<AggregateResult>();
        try{
        	Year = Integer.valueOf(apexpages.currentpage().getparameters().get('year'));
        	AggregateResult_list.addall([ select Account__r.owner.id, Account__r.owner.name ownername, Account__r.owner.SalesRepId1__c repid, sum(Budgeted_Sales__c)Budgeted_Sales , sum(Projected_Amount__c)Projected_Amount from Account_Yearly_Forecast__c WHERE CALENDAR_YEAR(Forecast_Period_Start__c) =:year group by Account__r.owner.id, Account__r.owner.name, Account__r.owner.SalesRepId1__c ]);            
        }catch(exception e){
            system.debug(e);
        }            
    }
}