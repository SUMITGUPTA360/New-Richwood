@isTest
public class Test_SalesForecastCSVExport_ctrl {
    static testMethod void test(){
        ApexPages.CurrentPage().getParameters().put('year','2017');
        SalesForecastCSVExport_ctrl obj = new SalesForecastCSVExport_ctrl();
        ApexPages.CurrentPage().getParameters().put('year','year');
        SalesForecastCSVExport_ctrl obj1 = new SalesForecastCSVExport_ctrl();

    }
}